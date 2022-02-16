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
        guard let product = place?.product else { return }
        guard let imagePath = product.imagePath else { return }
        guard let imagePathURL = URL(string: imagePath) else { return }
        guard let pngImageData = snapshot.pngData() else { return }
        do {
            try pngImageData.write(to: imagePathURL)
            RealmManager.shared.updateImage(product.id, imagePath: imagePath)
        } catch {
            print(error)
        }
    }
    
    func putProductViewController(height: Int, width: Int) {
        guard let product = place?.product else { return }
        RealmManager.shared.updateSize(product.id, height: height, width: width)
    }
    
}
