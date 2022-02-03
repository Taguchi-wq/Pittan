//
//  SnapshotViewController.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/25.
//

import UIKit

final class SnapshotViewController: UIViewController {
    
    // MARK: - @IBOutlets
    /// スナップショットを表示するUIImageView
    @IBOutlet private weak var snapshotView: UIImageView!
    /// 保存ボタン
    @IBOutlet private weak var saveButton: UIButton!
    
    
    // MARK: - Properties
    /// 作成した製品
    private var product: Product?
    /// スナップショット
    private var snapshot: UIImage?

    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    // MARK: - Initialize
    func initialize(product: Product, snapshot: UIImage) {
        self.product = product
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
    }
}
