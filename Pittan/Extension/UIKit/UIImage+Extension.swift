//
//  UIImage+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/01.
//

import UIKit

public extension UIImage {
    
    convenience init?(imagePath: String?) {
        guard let imagePath = imagePath else { return nil }
        guard let fileURL = URL(string: imagePath) else { return nil }
        let filePath = fileURL.path
        self.init(contentsOfFile: filePath)
    }
    
}
