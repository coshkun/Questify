//
//  Extentions.swift
//  Questify
//
//  Created by Coskun Caner on 16.03.2019.
//  Copyright © 2019 Coskun Caner. All rights reserved.
//

import UIKit


//Lazy GLobal Loaders
var documentsDirectory:URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0] as URL
}()

var tempDirectory:URL = {
    let paths = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    return paths as URL
}()

var cleanDate: Date = {
    if _cleanDate != nil { return _cleanDate } else {
        var dateComponents = DateComponents()
        dateComponents.year = 0000
        dateComponents.month = 1
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        let cleanDate = Calendar.current.date(from: dateComponents)
        return cleanDate!
    }
}()
var _cleanDate:Date!

var dateFormatter: DateFormatter = {
    if _dateFormatter != nil { return _dateFormatter } else {
        let frmtr = DateFormatter()
        frmtr.locale = Locale.current
        frmtr.timeZone = TimeZone(abbreviation: "GMT+0:00") // Buna sakın dokunma, çevirme işlemi hatalı döner.
        return frmtr
    }
}()
var _dateFormatter:DateFormatter!

var numberFormatter: NumberFormatter = {
    if _numberFormatter != nil { return _numberFormatter } else {
        let frmtr = NumberFormatter()
        frmtr.locale = Locale.current
        return frmtr
    }
}()
var _numberFormatter:NumberFormatter!

var timeFormatter: DateComponentsFormatter = {
    if _timeFormatter != nil { return _timeFormatter } else {
        let frmtr = DateComponentsFormatter()
        return frmtr
    }
}()
var _timeFormatter: DateComponentsFormatter!







// *****************************************************
// MARK: - Start of Extensions
// *****************************************************
//TimeSpan to String
extension TimeInterval {
    var stringValue: String {
        if self.isNaN || !self.isCanonical { return "--:--:--" }
        timeFormatter.zeroFormattingBehavior = .pad
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        guard let sonuc = timeFormatter.string(from: self) else { return "--:--:--" }
        return sonuc
    }
}

//TimeSpan to String
extension Date {
    var stringValue: String {
        //if self.isNaN || !self.isCanonical { return "--:--:--" }
        dateFormatter.dateFormat = "dd.MM.yyyy"   // Set this format exactly same as service result
        var sonuc = "--/--/--"
        sonuc = dateFormatter.string(from: self)
        return sonuc
    }
    var stringDateTimeValue: String {
        //if self.isNaN || !self.isCanonical { return "--:--:--" }
        dateFormatter.dateFormat = "dd.MM.yyyy h:mm:ss"   // Set this format exactly same as service result
        var sonuc = "--/--/--"
        sonuc = dateFormatter.string(from: self)
        return sonuc
    }
    var stringTimeValue: String {
        //if self.isNaN || !self.isCanonical { return "--:--:--" }
        dateFormatter.dateFormat = "HH:mm:ss"   // Set this format exactly same as service result
        var sonuc = "--/--/--"
        sonuc = dateFormatter.string(from: self)
        return sonuc
    }
    var stringTimeWithoutSecondsValue: String {
        //if self.isNaN || !self.isCanonical { return "--:--:--" }
        dateFormatter.dateFormat = "HH:mm"   // Set this format exactly same as service result
        var sonuc = "--/--"
        sonuc = dateFormatter.string(from: self)
        return sonuc
    }
    var stringValueTR: String {
        //if self.isNaN || !self.isCanonical { return "--:--:--" }
        dateFormatter.dateFormat = "dd/MM/yyyy"   // Set this format exactly same as service result
        var sonuc = "--/--/--"
        sonuc = dateFormatter.string(from: self)
        return sonuc
    }
    var stringValueGB: String {
        //if self.isNaN || !self.isCanonical { return "--:--:--" }
        dateFormatter.dateFormat = "yyyy/MM/dd"   // Set this format exactly same as service result
        var sonuc = "--/--/--"
        sonuc = dateFormatter.string(from: self)
        return sonuc
    }
    var stringDateTimeValueGB: String {
        //if self.isNaN || !self.isCanonical { return "--:--:--" }
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"   // Set this format exactly same as service result
        var sonuc = "--/--/--"
        sonuc = dateFormatter.string(from: self)
        return sonuc
    }
    
    //    var stringDayTR: String {
    //        let weekDay = self.weekday
    //        switch weekDay {
    //        case 1: return "Pazar"
    //        case 2: return "Pazartesi"
    //        case 3: return "Salı"
    //        case 4: return "Çarşamba"
    //        case 5: return "Perşembe"
    //        case 6: return "Cuma"
    //        case 7: return "Cumartesi"
    //        default: return ""
    //        }
    //    }
    //
    //    var stringDayEN: String {
    //        let weekDay = self.weekday
    //        switch weekDay {
    //        case 1: return "Sunday"
    //        case 2: return "Monday"
    //        case 3: return "Tuesday"
    //        case 4: return "Wednesday"
    //        case 5: return "Thursday"
    //        case 6: return "Friday"
    //        case 7: return "Saturday"
    //        default: return ""
    //        }
    //    }
    
    init(fromString:String, withFormat:String) {
        let formatter = DateFormatter()
        formatter.dateFormat = withFormat //"dd/MM/yyyy"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        self = formatter.date(from: fromString) ?? cleanDate
    }
    
    /**
     Example, zoneTime: "GMT+0:00"
     */
    init(fromString:String, withFormat:String, zoneTime:String) {
        let formatter = DateFormatter()
        formatter.dateFormat = withFormat //"dd/MM/yyyy"
        formatter.timeZone = TimeZone(abbreviation: zoneTime)
        self = formatter.date(from: fromString) ?? cleanDate
    }
}

//String To Number Convertors
extension String {
    var numberValue:NSNumber {
        if self.isEmpty { return 0 }
        numberFormatter.numberStyle = .none
        guard let sonuc = numberFormatter.number(from: self) else { return 0 }
        return sonuc
    }
    var currencyValue:NSNumber {
        if self.isEmpty { return 0 }
        numberFormatter.decimalSeparator = ","
        numberFormatter.numberStyle = .decimal
        guard let sonuc = numberFormatter.number(from: self) else { return 0 }
        return sonuc
    }
    var currencyValueGB:NSNumber {
        if self.isEmpty { return 0 }
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        guard let sonuc = numberFormatter.number(from: self) else { return 0 }
        return sonuc
    }
    var dateValue:Date? {
        if self.isEmpty { return Date() }
        dateFormatter.dateFormat = "dd.MM.yyyy"   // Set this format exactly same as service result
        guard let sonuc = dateFormatter.date(from: self) else { return Date() }
        return sonuc
    }
    var dateValueGB:Date? {
        if self.isEmpty { return Date() }
        dateFormatter.dateFormat = "yyyy.MM.dd"   // Set this format exactly same as service result
        guard let sonuc = dateFormatter.date(from: self) else { return Date() }
        return sonuc
    }
    var dateValueFB:Date? {
        if self.isEmpty { return Date() }
        dateFormatter.dateFormat = "MM.dd.yyyy"   // Set this format exactly same as service result
        guard let sonuc = dateFormatter.date(from: self) else { return Date() }
        return sonuc
    }
    var dateTimeValue:Date? {
        if self.isEmpty { return Date() }
        dateFormatter.dateFormat = "dd.MM.yyyy h:mm:ss"   // Set this format exactly same as service result
        guard let sonuc = dateFormatter.date(from: self) else { return Date() }
        return sonuc
    }
    var dateTimeValueGB:Date? {
        if self.isEmpty { return Date() }
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"   // Set this format exactly same as service result
        guard let sonuc = dateFormatter.date(from: self) else { return Date() }
        return sonuc
    }
    var timeValue:Date? {
        if self.isEmpty { return cleanDate }
        dateFormatter.defaultDate = cleanDate
        dateFormatter.dateFormat = "hh:mm:ss"   // Set this format exactly same as service result
        guard let sonuc = dateFormatter.date(from: self) else { return cleanDate }
        return sonuc
    }
    
    init(fromDate:Date, withFormat:String) {
        let formatter = DateFormatter()
        formatter.defaultDate = cleanDate
        formatter.dateFormat = withFormat //"dd/MM/yyyy"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let sonuc = formatter.string(from: fromDate)
        self = sonuc
    }
    
    /// leading Zero(s)
    /**
     - Usage:
     let s = String(123)
     s.leftPadding(toLength: 8, withPad: "0") // "00000123"
     */
    func leftPadding(toLength: Int, withPad: String = " ") -> String {
        
        guard toLength > self.characters.count else { return self }
        
        let padding = String(repeating: withPad, count: toLength - self.characters.count)
        return padding + self
    }
}

//// Expected height and widht of string
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}


/// Extents UIButtons to add action with closures
public class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

public class NullableClosureSleeve {
    let closure: (()->())?
    
    init (_ closure: (()->())? ) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure?()
    }
}

extension UIControl {
    func add (for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}




// MARK: - ImageView Online Image Downloader
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) { //UIViewContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}




// MARK: - Constraints With Visual Formatting ( ❤️🧡💛 this little guy is my favorite 💚💙💜 )
extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary)) //NSLayoutFormatOptions()
    }
}



// MARK: - Swift Logical XOR operator
precedencegroup BooleanPrecedence { associativity: left }
infix operator ^^ : BooleanPrecedence
/**
 Swift Logical XOR operator
 ```
 true  ^^ true   // false
 true  ^^ false  // true
 false ^^ true   // true
 false ^^ false  // false
 ```
 - parameter lhs: First value.
 - parameter rhs: Second value.
 */
func ^^(lhs: Bool, rhs: Bool) -> Bool {
    return lhs != rhs
}





// *****************************************************
// MARK: - AND SO ON AND ON...
//         this file grooves like a sugar store..
//         if you like to see more, hire me guys ;)
// *****************************************************
