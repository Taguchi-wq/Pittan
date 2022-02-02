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
    
    private func createFilePathURL() -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let uuid = UUID().uuidString
        return documentURL.appendingPathComponent(uuid + ".png")
    }
    
    private func saveProduct() {
        guard let product = product else { return }
        guard let snapshot = snapshot else { return }
        guard let filePath = createFilePathURL() else { return }
        let pngImageData = snapshot.pngData()
        do {
            try pngImageData?.write(to: filePath)
            product.imagePath = filePath.absoluteString
            
            guard let addPlaceVC = self.storyboard?.instantiateViewController(with: AddPlaceViewController.self) else { return }
            addPlaceVC.modalPresentationStyle = .fullScreen
            addPlaceVC.initialize(product: product)
            present(addPlaceVC, animated: true)
        } catch {
            print("Failed to save the image")
        }
    }
    

    // MARK: - @IBActions
    /// saveボタンを押した時の処置
    @IBAction private func tappedSaveButton(_ sender: UIButton) {
        Alert.showSize(on: self, height: 1000, width: 2000) { _ in
            self.saveProduct()
        }
    }
}
