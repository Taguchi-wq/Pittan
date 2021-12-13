//
//  UIColor+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

public extension UIColor {
    
    /// アプリのメインカラー
    class var appMain: UIColor {
        return UIColor(named: "appMain")!
    }
    
    /// アプリのバックグラウンドカラー
    class var appBackground: UIColor {
        return UIColor(named: "appBackground")!
    }
    
    /// アプリの文字カラー
    class var appText: UIColor {
        return UIColor(named: "appText")!
    }
    
    /// ボーダーカラー
    class var appBorder: UIColor {
        return UIColor(named: "appBorder")!
    }
    
}
