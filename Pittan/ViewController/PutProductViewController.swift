//
//  PutProductViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/09.
//

import UIKit
import RealityKit

final class PutProductViewController: UIViewController {

    // MARK: - @IBOutlets
    /// ARView
    @IBOutlet private weak var arView: ARView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - @IBActions
    /// backボタンを押した時の処理
    @IBAction private func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
