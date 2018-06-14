//
//  PhotoController2.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 19.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Firebase

protocol PhotoControllerDelegate {
    func changePhoto(image: UIImage)
}

class PhotoController2: UIViewController {
    
    var image: UIImage!
    var selectedImage: UIImage?
    var newView: NewBookView!
    var delegate: PhotoControllerDelegate?
    
    var imageView: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = UIColor.white
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    let topView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        v.alpha = 0.5
        return v
    }()
    
    let cancelButton: UIButton = {
        let b = UIButton()
        b.setTitle("Cancel", for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        b.tintColor = UIColor.white
        b.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return b
    }()
    
    let saveButton: UIButton = {
        let b = UIButton()
        b.setTitle("Save", for: .normal)
        b.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        b.tintColor = UIColor.white
        b.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = self.image
        selectedImage = image
        self.view.addSubview(imageView)
        self.view.addSubview(topView)
        self.topView.addSubview(cancelButton)
        self.topView.addSubview(saveButton)
        setupConstraints()
    }
    
    @objc func cancelButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonPressed(){
        let newVC = NewBookController()
        if image != nil {
            newVC.bookImage = self.imageView.image
            delegate?.changePhoto(image: self.imageView.image!)
    }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension PhotoController2 {
    
    private func setupConstraints(){
        imageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: self.view.frame.width, height: self.view.frame.height))
        topView.anchor(top: self.view.safeTopAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), size: .init(width: self.view.frame.width, height: 60.0))
        cancelButton.anchor(top: self.view.safeTopAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16.0, left: 10.0, bottom: 0.0, right: 0.0), size: .init(width: 55.0, height: 30.0))
        saveButton.anchor(top: self.view.safeTopAnchor, leading: nil, bottom: nil, trailing: self.view.trailingAnchor, padding: .init(top: 16.0, left: 0.0, bottom: 0.0, right: 10.0), size: .init(width: 55.0, height: 30.0))
    }
    
}
