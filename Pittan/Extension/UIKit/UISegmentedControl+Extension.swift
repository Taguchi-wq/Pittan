//
//  UISegmentedControl+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/08.
//

import UIKit

public extension UISegmentedControl {
    
    // MARK: - Properties
    /// 選択されているカテゴリー
    var selectedCategory: Category {
        get {
            let category: Category = selectedSegmentIndex == 0 ? .curtain : .rug
            return category
        }
        set {
            selectedSegmentIndex = newValue.index
        }
    }
    
    
    // MARK: - Methods
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
