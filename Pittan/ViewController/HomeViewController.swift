//
//  HomeViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var places: [Place] = [
        Place(name: "name", imageName: "imageName", category: "category", height: 10.0, width: 10.0)
    ]
    
    
    // MARK: - @IBOutlets
    /// 設置場所を表示するUICollectionView
    @IBOutlet private weak var placeCollectionView: UICollectionView!
    /// 設置場所追加ボタン
    @IBOutlet private weak var addPlaceButton: UIButton!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(addPlaceButton)
        setupCollectionView(placeCollectionView)
    }
    
    
    // MARK: - Methods
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.register(cellType: PlaceCell.self)
        collectionView.collectionViewLayout = createLayout()
    }
    
    /// UIButtonを設定する
    /// - Parameter button: 設定するUIButton
    private func setupButton(_ button: UIButton) {
        button.layer.cornerRadius = 16
        button.addShadow()
    }
    
    
    // MARK: - @IBActions
    /// addPlaceButtonを押した時に呼ばれる
    @IBAction private func tappedAddPlaceButton(_ sender: UIButton) {
    }
    
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let placeCell = collectionView.reusableCell(with: PlaceCell.self, for: indexPath)
        placeCell.initialize(place: places[indexPath.item])
        return placeCell
    }
    
}


// MARK: - CollectionViewLayout
extension HomeViewController: CollectionViewLayout {
    
    /// collectionViewのレイアウトを作成する
    /// - Returns: collectionViewのレイアウト
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createPlaceSectionLayout()
        }
        
        return layout
    }
    
    /// 設置場所を表示するcollectionViewのセクションレイアウトを作成する
    /// - Returns: collectionViewのセクションレイアウト
    private func createPlaceSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
    
}
