//
//  ProductCell.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/03.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    // MARK: - @IBOutlets
    /// 製品の画像を表示するUIImageView
    @IBOutlet private weak var imageView: UIImageView!
    /// 製品を選択した時にチェックを表示するUIImageView
    @IBOutlet private weak var selectCheckImageView: UIImageView!
    /// 製品の名前を表示するUILabel
    @IBOutlet private weak var nameLabel: UILabel!

    
    // MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    
    // MARK: - Initialize
    func initialize(imageName: String, name: String, isSelected: Bool) {
        imageView.image = UIImage(named: imageName)
        imageView.backgroundColor = .appBackground
        selectCheckImageView.isHidden = !isSelected
        nameLabel.text = name
    }

    
    // MARK: - Methods
    /// ProductCellのレイアウトを設定する
    private func setupLayout() {
        imageView.cornerRadius = 10
        imageView.addBorder(color: .black)
        selectCheckImageView.isHidden = true
        selectCheckImageView.cornerRadius = 10
    }
    
}
