//
//  UIImageView+Extension.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 16.05.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = URLRequest(url: url as URL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let imageData = data as Data? {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData)
                    }
                }
            }
            task.resume()
        }
    }
}
