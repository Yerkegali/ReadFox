//
//  UIStackView+Extension.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 15.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

extension UIView {
    
    func createStackview(views: [UIView]) -> UIStackView{
        
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15.0
        return stackView
    }
    
    func createHorizStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16.0
        return stackView
    }
    
    func createHorizStackView2(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 7.0
        return stackView
    }
}

extension UITextField {
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(r: 255.0, g: 0.0, b: 124.0, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}

