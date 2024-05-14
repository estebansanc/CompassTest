//
//  UserDefaultsHelper.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 14/05/2024.
//

import Foundation

class UserDefaultsHelper {
    
    static func saveAboutResponse(_ response: String) {
        UserDefaults.standard.setValue(response, forKey: "AboutResponse")
        UserDefaults.standard.synchronize()
    }
    
    static func getAboutResponse() -> String? {
        return UserDefaults.standard.string(forKey: "AboutResponse")
    }
}
