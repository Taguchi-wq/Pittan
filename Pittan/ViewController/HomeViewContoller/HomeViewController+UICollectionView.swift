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
    
}
