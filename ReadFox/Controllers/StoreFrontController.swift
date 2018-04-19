//
//  StoreFrontController.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 27.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Firebase

class StoreFrontController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        tabBar.barTintColor = UIColor.white
        setupTabBar()
    }
    
    func setupTabBar(){
        
        let homeController = createNavController(vc: HomeController(), selected: #imageLiteral(resourceName: "homeIconSelected"), unselected: #imageLiteral(resourceName: "homeIcon"))
        let profileController = createNavController(vc: ProfileController(), selected: #imageLiteral(resourceName: "profileIconSelected"), unselected: #imageLiteral(resourceName: "profileIcon"))
        
        viewControllers = [homeController, profileController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsetsMake(4, 0, -4, 0)
        }
        
    }
}

extension UITabBarController {
    
    func createNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewContoller = vc
        let navController = UINavigationController(rootViewController: viewContoller)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected.withRenderingMode(.alwaysOriginal)
        return navController
    }
}



