//
//  UIImageView+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/01.
//

import UIKit

public extension UIImageView {
    
    /// アプリ上にある画像で初期化する
    convenience init(appImage: AppImage) {
        let image = UIImage(named: appImage.name)
        self.init(image: image)
    }
    
}
