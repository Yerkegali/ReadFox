//
//  NewBookView.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 04.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class NewBookView: UIView {
    
    var gradientLayer: CAGradientLayer!
    var stackview: UIStackView!
    
    var addBookImageAction: (() -> Void)?
    var nowOrLaterAction: (() -> UISegmentedControl)?
    
    let containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let bookDetailLabel: UILabel = {
        let l = UILabel()
        l.text = "Book Detail"
        l.textColor = UIColor.white
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        return l
    }()
    
    let bookTitle: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        return tf
    }()
    
    let authorTitle: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Author"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        return tf
    }()
    
    let numberOfPagesTitle: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Number of pages"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var  addBookImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "addImageButtonImage")
        
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddBookImage)))
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    let willReadLabel: UILabel = {
        let l = UILabel()
        l.text = "will Read:"
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
        l.alpha = 0.5
        return l
    }()
    
    let descriptionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        l.textAlignment = .justified
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createGradienLayer()
        setupView()
        setupConstraints()
    }
    
    @objc func handleAddBookImage(){
        addBookImageAction?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        stackview = createStackview(views: [bookTitle, authorTitle, numberOfPagesTitle])
        
        containerView1.addSubview(addBookImage)
        containerView1.addSubview(stackview)
        containerView1.addSubview(willReadLabel)
        containerView1.addSubview(descriptionLabel)
        [bookDetailLabel, containerView1].forEach(){
            self.addSubview($0)
        }
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
    
    private func setupConstraints(){
        bookDetailLabel.anchor(top: self.safeTopAnchor, leading: self.safeLeadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26.0, left: 9.0, bottom: 0.0, right: 0.0))
        containerView1.anchor(top: bookDetailLabel.bottomAnchor, leading: self.safeLeadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15.0, left: 9.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/(1.052), height: self.frame.height/1.560))
        addBookImage.anchor(top: containerView1.topAnchor, leading: containerView1.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30.0, left: 12.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/4.848, height: self.frame.height/6.241))
        stackview.anchor(top: containerView1.topAnchor, leading: addBookImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15.0, left: 11.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/1.576, height: self.frame.height/4.733))
        willReadLabel.anchor(top: stackview.bottomAnchor, leading: addBookImage.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 19.0, left: 11.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/4, height: self.frame.height/35.5))
//        segmtControl.centerYAnchor.constraint(equalTo: willReadLabel.centerYAnchor).isActive = true
//        segmtControl.anchor(top: nil, leading: nil, bottom: nil, trailing: stackview.trailingAnchor, padding: .init(top: 15.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/2.461, height: 25.0))
        descriptionLabel.anchor(top: willReadLabel.bottomAnchor, leading: containerView1.leadingAnchor, bottom: containerView1.bottomAnchor, trailing: containerView1.trailingAnchor, padding: .init(top: 15.0, left: 12.0, bottom: 1.0, right: 15.0))
        
    }
}

