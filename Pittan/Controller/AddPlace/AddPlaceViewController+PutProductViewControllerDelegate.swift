//
//  AddPlaceViewController+PutProductViewControllerDelegate.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/05.
//

import UIKit

// MARK: - PutProductViewControllerDelegate
extension AddPlaceViewController: PutProductViewControllerDelegate {
    
    func putProductViewController(snapshot: UIImage) {
        self.snapshot = snapshot
    }
    
}
