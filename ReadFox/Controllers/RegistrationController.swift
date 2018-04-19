//
//  RegistrationViewController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 15.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    var registrationView: RegistrationView!
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor(r: 255, g: 0, b: 124, alpha: 1)
        
        setupViews()
        setupConstraints()
    }
}

extension RegistrationController {
    
    private func setupViews(){
    
    let mainView = RegistrationView(frame: view.frame)
    self.registrationView = mainView
    self.registrationView.doneAction = doneButtonPressed
    // add view
    self.view.addSubview(registrationView)
}
    
    func doneButtonPressed(){
        guard let name = registrationView.nameTextField.text else { return }
        guard let email = registrationView.emailTextField.text else { return }
        guard let password = registrationView.passwordTextField.text else { return }

        FirebaseAPI.shared.signUp(name: name, email: email, password: password) { [weak self] (err) in
            if err != nil {
                print(err?.localizedDescription as Any)
            } else {
                self?.showLoginController()
            }
        }
}
    func showLoginController() {
        self.present(LoginController(), animated: true, completion: nil)
    }
    
    func setupConstraints(){
        registrationView.fillSuperView()
    }
}

