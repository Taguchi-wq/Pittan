//
//  UIStoryboard+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/02.
//

import UIKit

extension UIStoryboard {
    
    /// ViewControllerをインスタンス化する
    /// - Returns: インスタンス化したViewController
    func instantiateViewController<T: UIViewController>(with type: T.Type) -> T {
        instantiateViewController(withIdentifier: type.className) as! T
    }
    
    /// UINavigationControllerを挟んだ画面遷移をする
    /// - Returns: <#description#>
    func instantiateNavigationController<T: UIViewController>(with type: T.Type) -> UINavigationController {
        instantiateViewController(withIdentifier: type.className) as! UINavigationController
    }
    
}
