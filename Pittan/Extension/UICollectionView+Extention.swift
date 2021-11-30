//
//  UICollectionView+Extention.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

extension UICollectionView {
    
    /// UINibでcellを登録する
    /// - Parameters:
    ///   - cellType: cellのタイプ
    ///   - bundle: バンドル
    func register(cellType: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    /// cellを再利用する
    /// - Returns: cell
    func reusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
}
