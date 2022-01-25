//
//  SnapshotViewController.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/25.
//

import UIKit

class SnapshotViewController: UIViewController {
    
    // MARK: - @IBOutlets
    /// スナップショットを表示するUIImageView
    @IBOutlet private weak var snapshotView: UIImageView!
    /// 保存ボタン
    @IBOutlet private weak var saveButton: UIButton!
    
    
    // MARK: - Properties
    /// スナップショット
    private var snapshot: UIImage?

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    // MARK: - Initialize
    func initialize(snapshot: UIImage) {
        self.snapshot = snapshot
    }
    
    
    // MARK: - Methods
    /// 画面のレイアウトをsetteisuru
    private func setupLayout() {
        snapshotView.image = snapshot
        saveButton.cornerRadius = 20
    }

    // MARK: - @IBActions
    /// saveボタンを押した時の処置
    @IBAction private func tappedSaveButton(_ sender: UIButton) {
        Alert.showSize(on: self, height: 1000, width: 2000) { _ in
            self.presentingViewController?
                .presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
