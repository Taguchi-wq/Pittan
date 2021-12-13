//
//  Alert.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/10.
//

import UIKit

class Alert {
    
    /// 基本的なアラートを構成する
    /// - Parameters:
    ///   - title: アラートのタイトル
    ///   - message: アラートのメッセージ
    /// - Returns: アラート
    private static func configureBasicAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    /// アラートを表示する
    /// - Parameters:
    ///   - viewController: アラートを表示したいViewController
    ///   - message: アラートのメッセージ
    static func show(on viewController: UIViewController, message: AlertMessage) {
        let alert = configureBasicAlert(title: "エラー", message: message.rawValue)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
