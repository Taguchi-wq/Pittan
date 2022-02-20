//
//  HomeViewController+UICollectionView.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/21.
//

import UIKit

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

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let placeDetailVC = storyboard?.instantiateViewController(with: PlaceDetailViewController.self) else { return }
        placeDetailVC.initialize(place: places[indexPath.item])
        navigationController?.pushViewController(placeDetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        configureContextMenu(index: indexPath.item)
    }
    
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            let delete = UIAction(title: "削除",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive,
                                  state: .off) { _ in
                let place = self.places[index]
                RealmManager.shared.deletePlace(place.id)
                self.places = RealmManager.shared.fetch(Place.self)
                self.placeCollectionView.reloadData()
            }
            return UIMenu(title: "",
                          image: nil,
                          identifier: nil,
                          options: .displayInline,
                          children: [delete])
        }
        return context
    }

}
