//
//  LoginView.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 17.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {
  
    var gradientLayer: CAGradientLayer!
    
    var stackView: UIStackView!
    
    var signInAction: (() -> Void)?
    
    var moveDistance = 0
    
    let containerView1: UIView = {
        let view1 = UIView()
        return view1
    }()
    
    let containerView2: UIView = {
        let view2 = UIView()
        return view2
    }()
    
    let minLogoView: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " E-mail"
        tf.autocorrectionType = .no
        tf.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon2")
        imageView.image = image
        tf.rightView = imageView
        
        tf.tag = 0
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = " Password"
        tf.autocorrectionType = .no
        tf.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon3")
        imageView.alpha = 0.3
        imageView.image = image
        tf.rightView = imageView
        
        tf.tag = 1
        
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        createGradienLayer()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        
    }
    
    @objc func handleSignIn() {
        signInAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height + 30.0)
            let viewHeight : Int = Int(frame.height)
            let btnPosition: Int = Int(stackView.frame.origin.y + loginButton.frame.origin.y - 180.0)
            
            if (moveDistance == 0) {
                
                moveDistance = (viewHeight - keyboardHeight) - btnPosition
                moveTextField(moveDistance: self.moveDistance, up: true)
            }
        }
    }
    
    func moveTextField(moveDistance: Int, up: Bool) {
        let moveDuration = 0.5
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        stackView.frame = stackView.frame.offsetBy(dx: 0, dy: movement)
        loginButton.frame = loginButton.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(moveDistance: self.moveDistance, up: true)
        minLogoView.alpha = 0.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(moveDistance: self.moveDistance, up: false)
        minLogoView.alpha = 1.0
    }
    
    @available (iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        moveTextField(moveDistance: self.moveDistance, up: false)
        minLogoView.alpha = 1.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            emailTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func createGradienLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(r: 254.0, g: 108.0, b: 93.0, alpha: 1.0).cgColor, UIColor(r: 255.0, g: 0.0, b: 124.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        loginButton.layer.insertSublayer(gradientLayer, at: 0)
        loginButton.layer.masksToBounds = true
    }
    
    private func setupViews(){
        stackView = createStackview(views: [emailTextField, passwordTextField])
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        [containerView1, minLogoView, containerView2, stackView, loginButton].forEach(){
            self.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        
        containerView1.anchor(top: self.safeTopAnchor, leading: self.safeLeadingAnchor,
                              bottom: nil, trailing: self.safeTrailingAnchor,
                              size: .init(width: 0, height: self.frame.height/3.0))
        
        minLogoView.centerAnchor(to: containerView1)
        minLogoView.anchor(top: nil, leading: nil,
                           bottom: nil, trailing: nil,
                           size: .init(width: self.frame.width/6.037, height: self.frame.height/10.327))
        
        containerView2.anchor(top: containerView1.bottomAnchor, leading: self.safeLeadingAnchor,
                              bottom: self.safeBottomAnchor, trailing: self.safeTrailingAnchor)
        
        stackView.centerXAnchor.constraint(equalTo: containerView2.centerXAnchor).isActive = true
        stackView.anchor(top: containerView2.topAnchor, leading: nil,
                         bottom: nil, trailing: nil,
                         size: .init(width: self.frame.width/1.142, height: self.frame.height/6.926))
        
        loginButton.centerXAnchor.constraint(equalTo: containerView2.centerXAnchor).isActive = true
        loginButton.anchor(top: stackView.bottomAnchor, leading: nil,
                           bottom: nil, trailing: nil,
                           padding: .init(top: 80.0, left: 0.0, bottom: 0.0, right: 0.0),
                           size: .init(width: self.frame.width/1.142, height: 49.0))
    }
}
