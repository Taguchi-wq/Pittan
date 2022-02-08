//
//  UIViewController+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/08.
//

import UIKit

public extension UIViewController {
    
    // MARK: - Methods
    /// キーボードを開いたときにviewごとあげる処理を設定する
    func setupKeyboardWill() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    /// viewを上げる
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardSize.height
        } else {
            let suggestionHeight = view.frame.origin.y + keyboardSize.height
            view.frame.origin.y -= suggestionHeight
        }
    }
    
    /// viewを下げる
    @objc
    private func keyboardWillHide() {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
}
