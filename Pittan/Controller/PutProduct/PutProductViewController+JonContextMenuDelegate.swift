//
//  PutProductViewController+JonContextMenuDelegate.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/18.
//

import UIKit
import JonContextMenu

// MARK: - JonContextMenuDelegate
extension PutProductViewController: JonContextMenuDelegate {
    
    func menuOpened() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func menuItemWasSelected(item: JonItem) {
        guard let index = item.id else { return }
        let pattern = PatternKind.allCases[index].imageName
        if let selectedObject = objectInteraction.selectedObject {
            selectedObject.setTexture(pattern)
            objectInteraction.selectedPattern = pattern
        }
    }
    
    func menuItemWasActivated(item: JonItem) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func menuClosed() {}
    
    func menuItemWasDeactivated(item: JonItem) {}
    
}
