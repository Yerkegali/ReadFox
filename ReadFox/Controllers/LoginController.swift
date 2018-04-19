//
//  ViewController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 14.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor(r: 255, g: 0, b: 124, alpha: 1)
        
        setupViews()
        setupConstraints()

    }
}

extension LoginController{
    
    private func setupViews() {
        
        let mainView = LoginView(frame: view.frame)
        self.loginView = mainView
        self.loginView.signInAction = sigInButtonPrssed
        self.view.addSubview(loginView)
    }
    
    func sigInButtonPrssed(){
        guard let email = loginView.emailTextField.text else { return }
        guard let password = loginView.passwordTextField.text else { return }
        
        FirebaseAPI.shared.signIn(email: email, password: password) { (err) in
            if err != nil {
                
            } else {
                self.showMainController() 
            }
        }
    }
    
    func showMainController() {
        self.present(StoreFrontController(), animated: true, completion: nil)
    }

    private func setupConstraints() {
        loginView.fillSuperView()
    }
}




