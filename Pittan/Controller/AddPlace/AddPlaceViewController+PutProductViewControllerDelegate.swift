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
    
    func putProductViewController(height: Int, width: Int) {
        guard let product = place?.product else { return }
        RealmManager.shared.updateSize(product.id, height: height, width: width)
    }
    
}
