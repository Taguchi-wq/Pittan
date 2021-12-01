//
//  UIImage+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/01.
//

import UIKit

extension UIImageView {
    
    /// アプリ上にある画像で初期化する
    convenience init(appImage: AppImage) {
        let image = UIImage(named: appImage.name)
        self.init(image: image)
    }
    
}
