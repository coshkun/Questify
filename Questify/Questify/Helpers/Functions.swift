//
//  Functions.swift
//  Questify
//
//  Created by Coskun Caner on 16.03.2019.
//  Copyright © 2019 Coskun Caner. All rights reserved.
//

import UIKit


// MARK: - DEBUGING TOOLS
// Some of Debug Logers
func debugUserDefaults() {
        //        print("---- DEBUG MODE: \(DataModel.shared.DebugMode) ----")
        print("---- USER DEFAULTS ----")
        print("----------------------------------")
        print("onFirstBoot: \(UserDefaults.standard.object(forKey: "onFirstBoot") as? Bool ?? false )")
        print("DebugMode: \(UserDefaults.standard.object(forKey: "DebugMode") as? Bool ?? false )")
        print("UserLogedIn: \(UserDefaults.standard.object(forKey: "UserLogedIn") as? Bool ?? false )")
        print("isRegisteredUser: \(UserDefaults.standard.object(forKey: "isRegisteredUser") as? Bool ?? false )")
        print("isSuspended: \(UserDefaults.standard.object(forKey: "isSuspended") as? Bool ?? false )")
        print("BootTime: \( (UserDefaults.standard.object(forKey: "BootTime")  as? Date ?? cleanDate).stringDateTimeValue )")
        print("AppToken: \(UserDefaults.standard.object(forKey: "AppToken") as? String ?? "" )")
        print("AppID: \(UserDefaults.standard.object(forKey: "AppID")  as? String ?? "" )")
        print("LoginTimeOut: \(UserDefaults.standard.object(forKey: "LoginTimeOut") as? Int ?? 0)")
        print("DeviceTokenForSNS: \(UserDefaults.standard.object(forKey: "deviceTokenForSNS")  as? String ?? "")")
        print("EndPointARNforSNS: \(UserDefaults.standard.object(forKey: "endpointARNforSNS")  as? String ?? "")")
        print("----------------------------------")
}

func debugDocumentsDirectory() {
        print("---- Documents Directory ----")
        print("----------------------------------")
        print(documentsDirectory)
        print("----------------------------------")
}


func debugFontsSupported(){
    print("--- Supported Fonts on Device ----")
    print("----------------------------------")
    for family: String in UIFont.familyNames
    {
        print("\(family)")
        for names: String in UIFont.fontNames(forFamilyName: family)
        {
            print("== \(names)")
        }
    }
    print("----------------------------------")
}
