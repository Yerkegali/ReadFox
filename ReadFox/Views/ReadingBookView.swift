//
//  ReadingBookView.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 29.05.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class ReadingBookView: UIView {
    
    var deleteBookAction: (() -> Void)?
    var gradientLayer: CAGradientLayer!
    var stackview: UIStackView!
    
    let containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let bookImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    let bookNameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        l.numberOfLines = 0
        return l
    }()
    
    let authorLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        return l
    }()
    
    let pageCountLabel: UILabel = {
        let l = UILabel()
        l.text = "pageCount"
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        return l
    }()
    
    let editButton: UIButton = {
        let b = UIButton()
        b.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
        b.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        return b
    }()
    
    let progressView: UIProgressView = {
        let p = UIProgressView(progressViewStyle: .bar)
        p.setProgress(0.5, animated: true)
        p.trackTintColor = UIColor(r: 255, g: 188, b: 203, alpha: 1)
        p.tintColor = UIColor(r: 255, g: 64, b: 105, alpha: 1)
        
        return p
    }()
    
    let progressLabel: UILabel = {
        let l = UILabel()
        l.text = "259 of 1024 pages read"
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        l.textColor = UIColor.black
        return l
    }()
    
    let startButton: UIButton = {
        let b = UIButton()
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        b.setTitle("Start Reading", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        return b
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createGradienLayer()
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDelete(){
        deleteBookAction?()
    }
    
    func createGradienLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(r: 242.0, g: 126.0, b: 82.0, alpha: 1.0).cgColor, UIColor(r: 255.0, g: 53.0, b: 108.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        layer.addSublayer(gradientLayer)
    }
    
    private func setupView(){
        
        stackview = createStackView2(views: [bookNameLabel, authorLabel, pageCountLabel])
        
        containerView1.addSubview(bookImage)
        containerView1.addSubview(stackview)
        containerView1.addSubview(editButton)
        containerView1.addSubview(progressView)
        containerView1.addSubview(progressLabel)
        containerView1.addSubview(startButton)
        [containerView1].forEach(){
            self.addSubview($0)
        }
    }
    
    private func setupConstraints(){
        containerView1.anchor(top: self.safeTopAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: self.frame.width, height: self.frame.height/2.272))
        bookImage.anchor(top: containerView1.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 27, left: 16, bottom: 0, right: 0), size: .init(width: self.frame.width/5.614, height: self.frame.height/6.604))
        stackview.anchor(top: containerView1.topAnchor, leading: bookImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 27, left: 16, bottom: 0, right: 0), size: .init(width: self.frame.width/1.481, height: self.frame.height/6.5))
        
        editButton.anchor(top: nil, leading: nil, bottom: bookImage.bottomAnchor, trailing: safeTrailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: self.frame.width/16, height: self.frame.height/28.4))
        
        progressView.centerXAnchor.constraint(equalTo: containerView1.centerXAnchor).isActive = true
        progressView.anchor(top: bookImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 29, left: 0, bottom: 0, right: 0), size: .init(width: self.frame.width/1.194, height: 4))
    
        progressLabel.centerXAnchor.constraint(equalTo: containerView1.centerXAnchor).isActive = true
        progressLabel.anchor(top: progressView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: self.frame.width/2.480, height: 12))
        
        startButton.centerXAnchor.constraint(equalTo: containerView1.centerXAnchor).isActive = true
        startButton.anchor(top: nil, leading: nil, bottom: containerView1.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 27, right: 0), size: .init(width: self.frame.width/2.782, height: self.frame.height/28.4))
    }
    
}
