//
//  HomeView.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 02.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    var gradientLayer: CAGradientLayer!
    var plusBtnAction: (() -> Void)?
    var topStackView: UIStackView!
    var middleStackView: UIStackView!
    
    let readingView: UIView = {
        let view = UIView()
        return view
    }()
    
    let mustReadView: UIView = {
        let view = UIView()
        return view
    }()
    
    let readingButton: UIButton = {
        let b = UIButton()
        b.setTitle("Reading", for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(defineView(sender:)), for: .touchUpInside)
        b.tag = 0
        return b
    }()
    
    
    let mustReadButton: UIButton = {
        let b = UIButton()
        b.setTitle("Must read", for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        b.setTitleColor(UIColor.lightGray, for: .normal)
        b.addTarget(self, action: #selector(defineView(sender:)), for: .touchUpInside)
        b.addBottomBorder(UIColor.clear, height: 2)
        b.tag = 1
        return b
    }()
    
    let readingtLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your reading bookshelf is empty"
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    let mustReadLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "The more that you read, the more things you will know. The more that you learn, the more places you’ll go"
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    let secondLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "to read right now"
        lbl.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    let addBookButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "addBookButton"), for: .normal)
        btn.addTarget(self, action: #selector(handlePlusBtn), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        createGradienLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func defineView(sender: UIButton) {
        
        if sender.tag == 0 {

            readingButton.setActive(state: true)
            mustReadButton.setActive(state: false)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.readingView.isHidden = false
                self.mustReadView.isHidden = true
            }, completion: nil)
            
            self.layoutIfNeeded()
            
            
        } else if sender.tag == 1 {
            
            readingButton.setActive(state: false)
            mustReadButton.setActive(state: true)
            
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                self.readingView.isHidden = true
                self.mustReadView.isHidden = false
            }, completion: nil)
            
            self.layoutIfNeeded()
        }
        
        
    }
    
    func createGradienLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(r: 242.0, g: 126.0, b: 82.0, alpha: 1.0).cgColor, UIColor(r: 255.0, g: 53.0, b: 108.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)

    }
    
    @objc func handlePlusBtn(){
        plusBtnAction?()
    }
    
    private func setupView(){
        
        defineView(sender: readingButton)
        
        topStackView = createHorizStackView(views: [readingButton, mustReadButton])
        middleStackView = createHorizStackView2(views: [secondLabel, addBookButton])
        
        readingView.addSubview(readingtLabel)
        readingView.addSubview(middleStackView)
        mustReadView.addSubview(mustReadLabel)
        
        [topStackView, readingView, mustReadView].forEach(){
            self.addSubview($0)
        }
        
    }
    
    private func setupConstraints(){
        
        topStackView.anchor(top: self.safeTopAnchor, leading: self.safeLeadingAnchor, bottom: nil, trailing: self.safeTrailingAnchor, padding: .init(top: 28.0, left: 63.0, bottom: 0.0, right: 63.0))
        
        readingView.anchor(top: self.topStackView.bottomAnchor, leading: self.safeLeadingAnchor, bottom: self.safeBottomAnchor, trailing: self.safeTrailingAnchor, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
        
        mustReadView.anchor(top: self.topStackView.bottomAnchor, leading: self.safeLeadingAnchor, bottom: self.safeBottomAnchor, trailing: self.safeTrailingAnchor, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
        
        readingtLabel.translatesAutoresizingMaskIntoConstraints = false
        readingtLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        readingtLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        middleStackView.topAnchor.constraint(equalTo: readingtLabel.bottomAnchor, constant: 21.0).isActive = true
        
        mustReadLabel.translatesAutoresizingMaskIntoConstraints = false
        mustReadLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mustReadLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mustReadLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 251.0, height: 70.0))
        
    }
    
}


