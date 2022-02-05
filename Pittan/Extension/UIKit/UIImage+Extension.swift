//
//  UIImage+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/01.
//

import UIKit

public extension UIImage {
    
    convenience init?(imagePath: String?) {
        if let imagePath = imagePath, let fileURL = URL(string: imagePath) {
            self.init(contentsOfFile: fileURL.path)
        } else {
            self.init(named: "no_image")
        }
    }
    
}
