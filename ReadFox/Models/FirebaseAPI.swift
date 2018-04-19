 //
//  FirebaseAPI.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 18.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import Foundation
import Firebase
 
 struct FirebaseAPI {
    
    static let shared = FirebaseAPI()
    
    private init(){
        
    }
    private let ref = Database.database().reference()
    
    var userID: String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }
    
    func signUp(name: String, email: String, password: String, completionHandler: @escaping (Error?) -> Void){
        
        let userData: [String: Any] = [
            "name": name,
            "email": email
        ]
        Auth.auth().createUserAndRetrieveData(withEmail: email, password: password) { (result, err) in
            if let err = err {
                print(err.localizedDescription)
                completionHandler(err)
            } else {
                guard (result?.user.uid) != nil else { return }
                self.ref.child("users").child(self.userID!).setValue(userData)
                UserDefaultManager.shared.userIsLoggedIn = false
                print("Created user with uid")
                completionHandler(nil)
            }
        }
    }
 
 
 func logOut(completionHandler: (Error?) -> Void){
    do {
       try Auth.auth().signOut()
        UserDefaultManager.shared.userIsLoggedIn = false
        completionHandler(nil)
        print("Good logout")
    } catch let err {
        print(err.localizedDescription)
        completionHandler(err)
    }
 }
 
 func signIn(email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
        if let err = err {
            print(err.localizedDescription)
            completionHandler(err)
        } else {
            guard let uid = user?.uid else { return }
            print("User: \(uid) is logged in successfully")
            UserDefaultManager.shared.userIsLoggedIn = true
            completionHandler(nil)
        }
    }
 }
 
 func fetch(completionHandler: @escaping (AppUser?) -> Void) {
        guard let userID = userID else { return }
    ref.child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
        let appUser = AppUser(snapshot: snapshot)
        completionHandler(appUser)
        print("Successfully fetched user info")
    }
}
    
}
