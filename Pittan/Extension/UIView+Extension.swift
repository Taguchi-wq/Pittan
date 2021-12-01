//
//  UIView+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

extension UIView {
    
    // MARK: - Properties
    /// 角丸
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    
    // MARK: - Methods
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
    
    /// ボーダーをつける
    /// - Parameters:
    ///   - width: ボーダーの太さ
    ///   - color: ボーダーの色
    ///   - cornerRadius: ボーダーの角丸
    func addBorder(width: CGFloat = 1, color: UIColor, cornerRadius: CGFloat = 0) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = cornerRadius
    }
    
}
