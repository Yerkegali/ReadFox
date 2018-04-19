//
//  RegistrationView.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 17.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class RegistrationView: UIView, UITextFieldDelegate {
    
    var gradientLayer: CAGradientLayer!
    
    var doneAction: (() -> Void)?

    var stackView: UIStackView!
    
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
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Name"
        tf.autocorrectionType = .no
        tf.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon1")
        imageView.image = image
        tf.rightView = imageView
        tf.autocapitalizationType = .words
        tf.tag = 0
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " E-mail"
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon2")
        imageView.alpha = 0.3
        imageView.image = image
        tf.rightView = imageView
        tf.tag = 1
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = " Password"
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no
        tf.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "icon3")
        imageView.alpha = 0.3
        imageView.image = image
        tf.rightView = imageView
        tf.tag = 2
        return tf
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        
        return button
    }()
    
    let agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("I agree with terms and conditions!", for: .normal)
        button.titleLabel?.font = UIFont(name: "I agree with terms and conditions!", size: 12)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor(r: 184.0, g: 184.0, b: 184.0, alpha: 1.0), for: .normal)
        return button
    }()
 
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        createGradienLayer()
        
        self.backgroundColor = .white
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func handleDone(){
        doneAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight : Int = Int(keyboardSize.height + 32.0)
            let viewHeight : Int = Int(frame.height)
            let btnPosition: Int = Int(stackView.frame.origin.y + doneButton.frame.origin.y - 200.0)
            
            if (moveDistance == 0) {

                moveDistance = (viewHeight - keyboardHeight) - btnPosition
                moveTextField(moveDistance: self.moveDistance, up: true)
            }
        }
    }
    
    func moveTextField(moveDistance: Int, up: Bool) {
        let moveDuration = 0.4
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        stackView.frame = stackView.frame.offsetBy(dx: 0, dy: movement)
        doneButton.frame = doneButton.frame.offsetBy(dx: 0, dy: movement)
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
    } else if textField.tag == 1 {
    passwordTextField.becomeFirstResponder()
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

        doneButton.layer.insertSublayer(gradientLayer, at: 0)
        doneButton.layer.masksToBounds = true

    }
    
    private func setupView() {
    
        nameTextField.setBottomBorder()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        
        stackView = createStackview(views: [nameTextField, emailTextField, passwordTextField])
        [containerView1, minLogoView, containerView2, stackView, doneButton, agreeButton].forEach {
            self.addSubview($0)
        }
}
 
    private func setupConstraints() {
    
        containerView1.anchor(top: self.safeTopAnchor, leading: self.safeLeadingAnchor,
                              bottom: nil, trailing: self.safeTrailingAnchor,
                              size: .init(width: 0, height: self.frame.height/3.0))
        
        minLogoView.centerAnchor(to: containerView1)
        minLogoView.anchor(top: nil, leading: nil,
                           bottom: nil, trailing: nil,
                           size: .init(width: self.frame.width/6.037, height: self.frame.height/10.327))
        
        containerView2.anchor(top: containerView1.bottomAnchor, leading: self.safeLeadingAnchor,
                              bottom: nil, trailing: self.safeTrailingAnchor,
                              size: .init(width: self.frame.width, height: self.frame.height/1.5))
        
        stackView.centerXAnchor.constraint(equalTo: containerView2.centerXAnchor).isActive = true
        stackView.anchor(top: containerView2.topAnchor, leading: nil,
                         bottom: nil, trailing: nil,
                         size: .init(width: self.frame.width/1.142, height: self.frame.height/4.617))
        
        doneButton.centerXAnchor.constraint(equalTo: containerView2.centerXAnchor).isActive = true
        doneButton.anchor(top: stackView.bottomAnchor, leading: nil,
                          bottom: nil, trailing: nil,
                          padding: .init(top: 30.0, left: 0.0, bottom: 0.0, right: 0.0),
                          size: .init(width: self.frame.width - 40.0, height: 49.0))
        
        agreeButton.centerXAnchor.constraint(equalTo: containerView2.centerXAnchor).isActive = true
        agreeButton.anchor(top: doneButton.bottomAnchor, leading: nil,
                           bottom: nil, trailing: nil,
                           padding: .init(top: 38.0, left: 0.0, bottom: 0.0, right: 0.0),
                           size: .init(width: self.frame.width - 40.0, height: self.frame.height/37.866))
    }
}
