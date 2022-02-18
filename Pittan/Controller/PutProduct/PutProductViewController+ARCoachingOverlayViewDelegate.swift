//
//  PutProductViewController+ARCoachingOverlayViewDelegate.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/21.
//

import UIKit
import ARKit

// MARK: - ARCoachingOverlayViewDelegate
extension PutProductViewController: ARCoachingOverlayViewDelegate {
    
    /// コーチングを設定する
    /// - Parameter goal: コーチングのゴール
    func setupCoachingOverlay(_ goal:  ARCoachingOverlayView.Goal) -> ARCoachingOverlayView {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = sceneView.session
        coachingOverlay.delegate = self
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        coachingOverlay.goal = goal
        view.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return coachingOverlay
    }
    
}
