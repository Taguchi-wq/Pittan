//
//  UISegmentedControl+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/08.
//

import UIKit

public extension UISegmentedControl {
    
    /// タイトルの色とフォントサイズを設定する
    /// - Parameters:
    ///   - color: 色
    ///   - fontSize: フォントサイズ
    ///   - state: controlの状態
    func setTitle(color: UIColor = .white, fontSize: CGFloat = 15, state: UIControl.State) {
        let attributes = [NSAttributedString.Key.foregroundColor: color,
                          NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
        setTitleTextAttributes(attributes, for: state)
    }
    
}
