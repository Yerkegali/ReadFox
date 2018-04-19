//
//  LoginView.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 17.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class FirstPageView: UIView {
    
    var gradientLayer: CAGradientLayer!
    
    var loginAction: (() -> Void)?
    var registrationAction: (() -> Void)?
    
    let containerView1: UIView = {
        let view1 = UIView()
        return view1
    }()
    
    let containerView2: UIView = {
        let view2 = UIView()
        return view2
    }()
    
    let logoImageView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "logo_readfox"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let regButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        let buttonText = "Already have an account? Sign in!"
        let buttonFont = UIFont(name: "HelveticaNeue-Medium", size: 14)
        
        let myAttr = [
            NSAttributedStringKey.font: buttonFont!,
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]

        let mutableString = NSMutableAttributedString(string: buttonText, attributes: myAttr)
        mutableString.addAttribute(NSAttributedStringKey.font, value: UIFont(name: "HelveticaNeue-Bold", size: 16) as Any, range: NSRange(location: 24, length: 9))
        
        button.backgroundColor = .white
        button.setAttributedTitle(mutableString, for: .normal)

        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        createGradienLayer()
        self.backgroundColor = .white

    }
    
    @objc func handleLogin(){
        loginAction?()
    }
    
    @objc func handleRegistration(){
        registrationAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createGradienLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(r: 254.0, g: 108.0, b: 93.0, alpha: 1.0).cgColor, UIColor(r: 255.0, g: 0.0, b: 124.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        regButton.layer.insertSublayer(gradientLayer, at: 0)
        regButton.layer.masksToBounds = true
        
    }
    
    private func setupViews() {
        
        [containerView1, logoImageView, containerView2, regButton, loginButton].forEach {
            self.addSubview($0)
        }
    
    }
    
    private func setupConstraints() {
        containerView1.anchor(top: self.safeTopAnchor, leading: self.safeLeadingAnchor,
                              bottom: nil, trailing: self.safeTrailingAnchor,
                              size: .init(width: 0, height: self.frame.height/2.0))
        
        logoImageView.centerAnchor(to: containerView1)
        logoImageView.anchor(top: nil, leading: nil,
                             bottom: nil, trailing: nil,
                             size: .init(width: self.frame.width/3.018, height: self.frame.height/4.854))

        containerView2.anchor(top: containerView1.bottomAnchor, leading: self.safeLeadingAnchor, bottom: self.safeBottomAnchor, trailing: self.safeTrailingAnchor)
        
        regButton.centerAnchor(to: containerView2)
        regButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width - 40, height: 50))
        
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginButton.anchor(top: regButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40.0, left: 0.0, bottom: 0.0, right: 0.0),size: .init(width: self.frame.width - 40, height: 20))        
    }
}

