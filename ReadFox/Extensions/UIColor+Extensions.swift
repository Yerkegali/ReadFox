//
//  UIColor+Extensions.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 15.03.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
}



