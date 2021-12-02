//
//  HomeViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    /// 画面サイズ
    private let screen = UIScreen.main.bounds
    /// セントラルお姉さん
    private let centralWoman = UIImageView(appImage: .centralWoman)
    /// 場所を格納する配列
    private var places = RealmManager.shared.fetch(Place.self)
    
    
    // MARK: - @IBOutlets
    /// 設置場所を表示するUICollectionView
    @IBOutlet private weak var placeCollectionView: UICollectionView!
    /// 設置場所追加ボタン
    @IBOutlet private weak var addPlaceButton: UIButton!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView(view)
        setupButton(addPlaceButton)
        setupCollectionView(placeCollectionView)
    }
    
    
    // MARK: - Methods
    /// UIViewを設定する
    private func setupView(_ view: UIView) {
        view.backgroundColor = .appBackground
    }
    
    /// UICollectionViewを設置する
    /// - Parameter collectionView: 設置するUICollectionView
    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.register(cellType: PlaceCell.self)
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .clear
    }
    
    /// UIButtonを設定する
    /// - Parameter button: 設定するUIButton
    private func setupButton(_ button: UIButton) {
        button.cornerRadius = 16
        button.backgroundColor = .appMain
        button.addShadow()
    }
    
    
    // MARK: - @IBActions
    /// addPlaceButtonを押した時に呼ばれる
    @IBAction private func tappedAddPlaceButton(_ sender: UIButton) {
        RealmManager.shared.savePlace()
        placeCollectionView.reloadData()
    }
    
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 設置場所がない時セントラルお姉さんを表示する
        if places.isEmpty {
            centralWoman.frame = CGRect(x: 0, y: 0, width: 321, height: 258)
            centralWoman.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
            view.addSubview(centralWoman)
            collectionView.isScrollEnabled = false
        } else {
            centralWoman.removeFromSuperview()
            collectionView.isScrollEnabled = true
        }
        
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
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 24
        section.contentInsets = .init(top: 40, leading: 16, bottom: 100, trailing: 16)
        
        return section
    }
    
}
