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
    ///   - handler: OKボタンを押した時の処理
    /// - Returns: アラート
    private static func configureBasicAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        return alert
    }
    
    /// エラーアラートを表示する
    /// - Parameters:
    ///   - viewController: アラートを表示したいViewController
    ///   - message: アラートのメッセージ
    static func showError(on viewController: UIViewController, message: AlertMessage) {
        let alert = configureBasicAlert(title: "エラー", message: message.rawValue, handler: nil)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    /// サイズアラートを表示する
    /// - Parameters:
    ///   - viewController: アラートを表示したいViewController
    ///   - height: カーテンの縦幅
    ///   - width: カーテンの横幅
    ///   - handler: OKボタンを押した時の処置
    static func showSize(on viewController: UIViewController,
                         height: Int,
                         width: Int,
                         handler: ((UIAlertAction) -> Void)?) {
        let message = "縦幅: \(height) mm\n横幅: \(width) mm"
        let alert = configureBasicAlert(title: "カーテンのサイズ", message: message, handler: handler)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    /// 開発中アラートを表示する
    /// - Parameters:
    ///   - viewController: アラートを表示したいViewController
    ///   - handler: OKボタンを押した時の処置
    static func showInDevelopment(on viewController: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let alert = configureBasicAlert(title: "大変申し訳ございません", message: "只今ラグは開発中でございます。楽しみにしていただいた方にはご迷惑をおかけしますが、ご理解のほどよろしくお願いいたします。", handler: handler)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
