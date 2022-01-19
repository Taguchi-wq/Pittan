//
//  PutProductViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/09.
//

import UIKit
import RealityKit

final class PutProductViewController: UIViewController {
    
    // MARK: - Enums
    private enum Section: CaseIterable {
        case tag
        case product
    }
    
    
    // MARK: - Properties
    /// 製品を格納する配列
    private var products: [String] = ["", "", "", "", "", "", "", "", "", ""]
    /// 選ばれているtag
    private var selectTag: Tag = .put
    

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
        putProductCollectionView.register(cellType: TagCell.self, bundle: nil)
        putProductCollectionView.register(cellType: SizeSliderCell.self, bundle: nil)
        putProductCollectionView.collectionViewLayout = createLayout()
        putProductCollectionView.isScrollEnabled = false
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        switch section {
        case .tag: return Tag.allCases.count
        case .product: return selectTag == .put ? products.count : 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .tag:
            let tagCell = collectionView.reusableCell(with: TagCell.self, for: indexPath)
            let tag = Tag.allCases[indexPath.item]
            if tag == selectTag {
                tagCell.initialize(title: tag.japanese, textColor: .appMain)
            } else {
                tagCell.initialize(title: tag.japanese)
            }
            return tagCell
        case .product:
            if selectTag == .put {
                let productCell = collectionView.reusableCell(with: ProductCell.self, for: indexPath)
                return productCell
            } else {
                let sizeSliderCell = collectionView.reusableCell(with: SizeSliderCell.self, for: indexPath)
                return sizeSliderCell
            }
        }
    }
    
}


// MARK: - UICollectionViewDelegate
extension PutProductViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .tag:
            selectTag = .allCases[indexPath.item]
            putProductCollectionView.reloadData()
        case .product:
            print("product")
        }
    }
    
}


// MARK: - CollectionViewLayout
extension PutProductViewController: CollectionViewLayout {
    
    /// collectionViewのレイアウトを作成する
    /// - Returns: collectionViewのレイアウト
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section = Section.allCases[sectionIndex]
            switch section {
            case .tag:
                return self.createTagSectionLayout()
            case .product:
                if self.selectTag == .put {
                    return self.createProductSectionLayout()
                } else {
                    return self.createSizeSliderSectionLayout()
                }
            }
        }
        
        return layout
    }
    
    /// tagを表示するcollectionViewのセクションレイアウトを作成する
    /// - Returns: collectionViewのセクションレイアウト
    private func createTagSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalWidth(0.05)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        return section
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
            widthDimension: .fractionalWidth(0.18),
            heightDimension: .fractionalWidth(0.24)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 20, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
    
    /// サイズを調節するスライダーを表示するcollectionViewのセクションレイアウトを作成する
    /// - Returns: collectionViewのセクションレイアウト
    private func createSizeSliderSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.24)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
    
}
