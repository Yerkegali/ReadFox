//
//  ProfileViewController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 02.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {

    var profileView: ProfileView!
    
    var appUser: AppUser? {
        didSet {
            guard let userName = appUser?.name else { return }
            navigationItem.title = userName
        }
    }
    
    let defaults = UserDefaults.standard
    
    var navigationTitle: UILabel = {
        let l = UILabel()
        l.textColor = UIColor.black
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = navigationTitle
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "SettingsIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(plusBtnTapped(_ :)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        setupView()
        setupConstraints()
        
        if let userID = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference().child("users").child(userID)
                ref.observeSingleEvent(of: .value) { (snapshot) in
                    print(snapshot)
                    print("key", snapshot.key)
                    print("value", snapshot.value ?? String())
                    
                    if let value = snapshot.value as? [String: String] {
                        guard let guardEmail = value["email"] else { return }
                        print("guard \(guardEmail)")
                        
                        if let ifEmail = value["email"] {
                            print("if \(ifEmail)")
                        }
                        
                        let questionEmail = value["email"] ?? "empty"
                        print("question \(questionEmail)")
                        
                    }
            }
        }
        
        
    }
    
    @objc func plusBtnTapped(_ sender: UIBarButtonItem) {
        print("plus tapped")
    }
    
    @objc func logOut(){
        FirebaseAPI.shared.logOut { [weak self] (err) in
            if err != nil {
                print(err?.localizedDescription as Any)
            } else {
                self?.showLoginController()
            }
        }
    }
    func fetchUserInfo(){
        FirebaseAPI.shared.fetch { [weak self] (user) in
            if user != nil {
                self?.appUser = user
            }
        }
    }
    
    func showLoginController() {
        let loginVC = UINavigationController(rootViewController: LoginController())
        self.present(loginVC, animated: true, completion: nil)
    }
    
}

extension ProfileController{
    
    private func setupView(){
        view.backgroundColor = UIColor.white
        let mainView = ProfileView(frame: view.frame)
        self.profileView = mainView
        self.view.addSubview(profileView)
    }
    
    private func setupConstraints(){
        profileView.fillSuperView()
    }
}
