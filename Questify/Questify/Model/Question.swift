//
//  Question.swift
//  Questify
//
//  Created by Coskun Appwox on 17.03.2019.
//  Copyright © 2019 Coskun Appwox. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Question {
    let id:Int
    var title:String      = ""
    var answers:[Answer]! = [Answer]()
}
extension Question {
    init() { self.id = 0 }
    
    init?(json:JSON) {
        guard json.count > 0 else {return nil}
        id      = json["id"].intValue
        title   = json["title"].stringValue
        answers = json["answers"].arrayValue.map { Answer(json: $0) }.compactMap { $0 }
    }
}



struct Answer {
    let id:Int
    var title:String    = ""
    var isSelected:Bool = false
    var isCorrect:Bool  = false
}
extension Answer {
    init() { self.id = 0 }
    
    init?(json:JSON) {
        guard json.count > 0 else {return nil}
        id         = json["id"].intValue
        title      = json["title"].stringValue
        isSelected = json["isSelected"].boolValue
        isCorrect  = json["isCorrect"].boolValue
    }
}
