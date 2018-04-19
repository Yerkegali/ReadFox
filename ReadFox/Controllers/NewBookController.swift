//
//  NewBookController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 04.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Firebase

class NewBookController: UIViewController {

    var newBookView: NewBookView!
    var ref: DatabaseReference!
    
    let imgBackArrow = UIImage(named: "leftArrowIcon")
    
    var navigationTitle: UILabel = {
        let l = UILabel()
        let boldText = NSMutableAttributedString(string: "New Book", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        l.attributedText = boldText
        l.textColor = UIColor.white
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = navigationTitle
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "saveButtonIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(saveBtnTapped(_:)))
//        tabBarController?.tabBar.isHidden = true
        ref = Database.database().reference()
        setupView()
        setupConstraints()
    }
    
    @objc func saveBtnTapped(_ sender: UIBarButtonItem) {
        guard let name = newBookView.bookTitle.text else { return }
        guard let author = newBookView.authorTitle.text else { return }
        guard let numOfPage = newBookView.numberOfPagesTitle.text else { return }
        
        let bookData = ["bookName": name,
                        "bookAuthor": author,
                        "pageNumber": numOfPage]
        self.ref.child("allBooks").child("ID").setValue(bookData) { (err, reference) in
            if err != nil {
                print(err?.localizedDescription as Any)
            } else {
                self.navigationController?.pushViewController(HomeController(), animated: false)
            }
        }
    }
}

extension NewBookController{
    
    private func setupView(){
        let mainView = NewBookView(frame: self.view.frame)
        self.newBookView = mainView
        self.view.addSubview(newBookView)
    }
    
    private func setupConstraints(){
        newBookView.fillSuperView()
    }
    
}
