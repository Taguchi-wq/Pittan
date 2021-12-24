//
//  UINavigationBar+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/23.
//

import UIKit

public extension UINavigationBar {
    
    /// navigationBarの下線を消す
    /// - Parameter isHide: 消すかどうか
    func hideShadow(_ isHide: Bool) {
        let shadowImage = isHide ? UIImage() : UIImage(named: "")
        self.shadowImage = shadowImage
    }
    
}
