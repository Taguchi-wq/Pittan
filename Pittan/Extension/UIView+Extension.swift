//
//  UIView+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

extension UIView {
    
    /// 影をつける
    /// - Parameters:
    ///   - width: 横の広がり
    ///   - height: 縦の広がり
    func addShadow(width: CGFloat = 0, height: CGFloat = 4) {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowRadius  = 10
        layer.shadowOffset  = CGSize(width: width, height: height)
        layer.shadowOpacity = 0.25
    }
    
}
