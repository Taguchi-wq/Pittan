//
//  PutProductViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/09.
//

import UIKit
import RealityKit

final class PutProductViewController: UIViewController {
    
    // MARK: - Properties
    /// 製品を格納する配列
    private var products: [String] = ["", "", "", "", "", "", "", "", "", ""]
    

    // MARK: - @IBOutlets
    /// ARView
    @IBOutlet private weak var arView: ARView!
    /// 製品を選ぶUICollectionView
    @IBOutlet private weak var putProductCollectionView: UICollectionView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    // MARK: - Methods
    /// レイアウトを設定する
    private func setupLayout() {
        putProductCollectionView.dataSource = self
        putProductCollectionView.delegate = self
        putProductCollectionView.register(cellType: ProductCell.self, bundle: nil)
        putProductCollectionView.collectionViewLayout = createLayout()
    }

    
    // MARK: - @IBActions
    /// backボタンを押した時の処理
    @IBAction private func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    /// pictureボタンを押した時の処理
    @IBAction private func tappedPictureButton(_ sender: UIButton) {
        
    }
    
    /// putボタンを押した時の処理
    @IBAction private func tappedPutButton(_ sender: UIButton) {
        
    }
    
}


// MARK: - UICollectionViewDataSource
extension PutProductViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCell = collectionView.reusableCell(with: ProductCell.self, for: indexPath)
        return productCell
    }
    
}


// MARK: - UICollectionViewDelegate
extension PutProductViewController: UICollectionViewDelegate {}


// MARK: - CollectionViewLayout
extension PutProductViewController: CollectionViewLayout {
    
    /// collectionViewのレイアウトを作成する
    /// - Returns: collectionViewのレイアウト
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createProductSectionLayout()
        }
        
        return layout
    }
    
    /// 製品を表示するcollectionViewのセクションレイアウトを作成する
    /// - Returns: collectionViewのセクションレイアウト
    private func createProductSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .fractionalWidth(0.3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 20, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
    
}
