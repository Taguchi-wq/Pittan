//
//  PutProductViewController+SizeSliderCellDelegate.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/21.
//

import Foundation

// MARK: - SizeSliderCellDelegate
extension PutProductViewController: SizeSliderCellDelegate {
    
    func changedHeight(_ value: Float) {
        objectInteraction.selectedObject?.height = value * 0.01
    }
    
    func changedWidth(_ value: Float) {
        objectInteraction.selectedObject?.width = value * 0.01
    }
    
}

