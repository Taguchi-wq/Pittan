//
//  PlaceCell.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

final class PlaceCell: UICollectionViewCell {
    
    // MARK: - @IBOutlets
    /// 設置場所の画像を表示するUIImageView
    @IBOutlet private var placeImageView: UIImageView!
    /// 設置場所の名前を表示するUILabel
    @IBOutlet private var placeNameLabel: UILabel!
    /// 設置場所のサイズの縦幅を表示するUILabel
    @IBOutlet private var placeHeightLabel: UILabel!
    /// 設置場所のサイズの横幅を表示するUILabel
    @IBOutlet private var placeWidthLabel: UILabel!
    /// 設置場所のカテゴリを表示するUILabel
    @IBOutlet private var categoryLabel: UILabel!
    

    // MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayout()
    }
    
    
    // MARK: - Initialize
    func initialize(place: Place) {
        guard let product = place.product else { return }
        placeImageView.image = UIImage(imagePath: product.imagePath)
        placeNameLabel.text = place.name
        placeHeightLabel.text = "縦幅: \(product.height) mm"
        placeWidthLabel.text = "横幅: \(product.width) mm"
        categoryLabel.text = product.category
    }

    
    // MARK: - Methods
    /// PlaceCellのレイアウトを設定する
    private func setupLayout() {
        cornerRadius = 20
        placeImageView.cornerRadius = 10
        categoryLabel.textColor = .appMain
        categoryLabel.cornerRadius = 17.5
        categoryLabel.addBorder(width: 2, color: .appMain)
    }
    
}
