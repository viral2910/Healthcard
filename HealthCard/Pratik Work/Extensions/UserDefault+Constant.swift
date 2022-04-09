//
//  UserDefault+Constant.swift
//  Level
//
//  Created by Pratik on 13/01/22.
//

import Foundation
import UIKit

extension UserDefaults {
//    var userDetails: UserLoginResponse? {
//        get {
//            let loginDetails = UserDefaults.standard.string(forKey: "userDetails") ?? ""
//            let decoded: UserLoginResponse? = UserLoginResponse.from(loginDetails)
//            print("str login details - ", loginDetails)
//            print(decoded)
//            return decoded
//        } set {
//            UserDefaults.standard.set(newValue?.stringValue, forKey: "userDetails")
//        }
//    }
    var login_token: String? {
        get {
            return UserDefaults.standard.string(forKey: "jwt")
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "jwt")
        }
    }
    var deviceToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "DeviceToken")
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "DeviceToken")
        }
    }
}
