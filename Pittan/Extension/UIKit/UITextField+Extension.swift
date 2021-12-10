//
//  UITextField+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/08.
//

import UIKit

public extension UITextField {
    
    /// 下線をつける
    /// - Parameter color: 下線の色
    func addBottomBorder(color: UIColor = .appBorder) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
    }
    
}
