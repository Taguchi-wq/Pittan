//
//  UITextView+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/08.
//

import UIKit

public extension UITextView {
    
    func addToolbar(_ action: @escaping () -> ()) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        toolBar.sizeToFit()
        let closeButton = UIBarButtonItem(title: "閉じる", style: .done, action: action)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.items = [spacer, closeButton]
        inputAccessoryView = toolBar
    }
    
}
