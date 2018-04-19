//
//  ProfileView.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 02.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    let containerView1: UIView = {
        let view = UIView()
        return view
    }()
    
    let containerView2: UIView = {
        let view = UIView()
        return view
    }()
    
    let containerView3: UIView = {
        let view = UIView()
        return view
    }()
    
    let levelsImage: UIImageView = {
        let iView = UIImageView(image: #imageLiteral(resourceName: "levelsPicture"))
        return iView
    }()
    
    let myReadSpeed: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "readingSpeed"))
        return view
    }()
    
    let myReadBooks: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "readBooks"))
        return view
    }()
    
    let booksImage: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "books"))
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView1.addSubview(levelsImage)
        containerView2.addSubview(myReadSpeed)
        containerView3.addSubview(myReadBooks)
        containerView3.addSubview(booksImage)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        [containerView1, containerView2, containerView3].forEach(){
            self.addSubview($0)
        }
    }
    
    private func setupConstraints(){

        containerView1.anchor(top: self.safeTopAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 30.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/0.8, height: self.frame.height/3.103))
        containerView2.anchor(top: containerView1.bottomAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width, height: self.frame.height/6.604))
        myReadSpeed.anchor(top: containerView2.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/2.237, height: self.frame.height/47.333))
        containerView3.anchor(top: containerView2.bottomAnchor, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.frame.width, height: self.frame.height/2.119))
        myReadBooks.anchor(top: containerView3.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/2.206, height: self.frame.height/47.333))
        booksImage.anchor(top: containerView3.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.frame.width/0.914, height: self.frame.height/3.5))
        
    }
}
