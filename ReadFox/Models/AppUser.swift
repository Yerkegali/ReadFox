//
//  AppUser.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 18.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import Foundation
import Firebase

struct AppUser {
    
    var name: String?
    var email: String?
    var userID: String?
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return }
        guard let name = value["name"] as? String else { return }
        self.name = name
    }
}
