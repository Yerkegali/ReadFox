//
//  UserDefaultManager.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 18.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import Foundation

struct Constants {
    struct Authentication {
        static let userIsLoggedIn = "UserIsLoggedIn"
    }
    
    private init(){
     
        
    }
}

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private init() {
        
    }
    
    var userIsLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.Authentication.userIsLoggedIn)
        }
        
        set {
            return UserDefaults.standard.set(newValue, forKey: Constants.Authentication.userIsLoggedIn)
        }
    }
    
}
