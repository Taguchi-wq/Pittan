//
//  AddPlaceViewController+UITextFieldDelegate.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/05.
//

import UIKit

// MARK: - UITextFieldDelegate
extension AddPlaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
