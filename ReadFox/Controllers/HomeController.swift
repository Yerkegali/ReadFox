//
//  HomeViewController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 02.04.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    
    var homeView: HomeView!

    
    var appUser: AppUser? {
        didSet {
            print("value set")
        }
    }
    
    var navigationTitle: UILabel = {
        let l = UILabel()
        let boldText = NSMutableAttributedString(string: "Read", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
        boldText.append(NSMutableAttributedString(string: "Fox", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]))
        l.attributedText = boldText
        l.textColor = UIColor.white
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(plusBtnPressed))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "leftArrowIcon")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "leftArrowIcon")
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupView()
        setupConstraints()
    }
 
    
    @objc func plusBtnPressed() {
        self.navigationController?.pushViewController(NewBookController(), animated: true)
    }
    
}

extension HomeController{
    
    private func setupView(){

        let mainView = HomeView(frame: view.frame)
        self.homeView = mainView
        self.homeView.plusBtnAction = plusBtnPressed
        self.view.addSubview(homeView)
    }
    
    private func setupConstraints(){
        homeView.fillSuperView()
    }
}
