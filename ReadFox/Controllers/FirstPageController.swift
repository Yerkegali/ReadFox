//
//  MainViewController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 17.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Foundation

class FirstPageController: UIViewController {
    
    var firstPageView: FirstPageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        setupView()
        setupConstraints()
        
    }
}

extension FirstPageController{
    
    private func setupView() {
        
        let mainView = FirstPageView(frame: view.frame)
        self.firstPageView = mainView
        self.firstPageView.loginAction = loginButtonPressed
        self.firstPageView.registrationAction = regButtonPressed
        // add view
        self.view.addSubview(firstPageView)
    }
    
    func loginButtonPressed() {
        self.navigationController?.pushViewController(LoginController(), animated: true)
    }
    
    func regButtonPressed() {
        self.navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    private func setupConstraints() {
        
        firstPageView.fillSuperView()
        
    }
    
}
