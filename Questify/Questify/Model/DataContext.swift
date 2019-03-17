//
//  DataContext.swift
//  Questify
//
//  Created by Coskun Appwox on 17.03.2019.
//  Copyright © 2019 Coskun Appwox. All rights reserved.
//

import Foundation
import SwiftyJSON


class DataContext {
    static let shared = DataContext()
    private init() { loadFromDisk() }
    
    var questions:[Question]! = [Question]()
    //var user:[UserInfo]! = [UserInfo]()
    
    
    
    func saveAllChanges() {
        // Serialize Questions
        let questionJSON = JSON(arrayLiteral: self.questions).rawString() ?? ""
        //let userJSON = JSON(arrayLiteral: self.user).rawString() ?? ""
        
        
        // Add them to the encoded container
        var container = [String:String]()
        container["questions"] = questionJSON
        //container["user"] = userJSON
        // add more when we need..
        
        
        // Then save to current BundleIdentifier (simple is that)
        UserDefaults.standard.set(container, forKey: "DataContextContainer")
        UserDefaults.standard.synchronize()
    }
    
    func loadFromDisk() {
        // Now we recover saved container
        guard let container = UserDefaults.standard.dictionary(forKey: "DataContextContainer") as? [String:String]
        else {
            // if No data container yet, that means we are coming here first time
            // just set the defaulsts (if necessary) and return
            questions = [Question]()
            return
        }
        
        
        //Here we have filled container, keep decoding..
        let questionJSON = JSON(parseJSON: container["questions"] ?? "" )
        if questionJSON.arrayValue.count > 0 {
            self.questions = questionJSON.arrayValue.map { Question(json: $0) }.compactMap { $0 }
        }
        
    }
    
}
