//
//  HomeViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

final class HomeViewController: UIViewController {
    
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
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        placeCollectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    // MARK: - Methods
    /// 画面のレイアウトを設定する
    private func setupLayout() {
        view.backgroundColor = .appBackground
        placeCollectionView.dataSource = self
        placeCollectionView.delegate = self
        placeCollectionView.register(cellType: PlaceCell.self)
        placeCollectionView.collectionViewLayout = createLayout()
        placeCollectionView.backgroundColor = .clear
        addPlaceButton.cornerRadius = 16
        addPlaceButton.backgroundColor = .appMain
        addPlaceButton.addShadow()
    }
    
    
    // MARK: - @IBActions
    /// addPlaceButtonを押した時に呼ばれる
    @IBAction private func tappedAddPlaceButton(_ sender: UIButton) {
        guard let addPlaceVC = storyboard?.instantiateViewController(with: AddPlaceViewController.self) else { return }
        addPlaceVC.modalPresentationStyle = .fullScreen
        present(addPlaceVC, animated: true)
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


// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeDetailVC = storyboard?.instantiateViewController(with: PlaceDetailViewController.self) else { return }
        placeDetailVC.initialize(place: places[indexPath.item])
        navigationController?.pushViewController(placeDetailVC, animated: true)
    }
    
}
