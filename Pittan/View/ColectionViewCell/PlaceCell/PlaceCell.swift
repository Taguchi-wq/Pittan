//
//  PlaceCell.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    
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
        
        setupPlaceCellLayout()
    }
    
    
    // MARK: - Initialize
    func initialize(place: Place) {
//        placeImageView.image = UIImage(named: place.imageName)
        placeNameLabel.text = place.name
//        placeHeightLabel.text = "縦幅: \(place.height) mm"
//        placeWidthLabel.text = "横幅: \(place.width) mm"
//        categoryLabel.text = place.category
        placeHeightLabel.text = "縦幅: ダミー mm"
        placeWidthLabel.text = "横幅: ダミー mm"
        categoryLabel.text = "カテゴリー"
    }

    
    // MARK: - Methods
    /// PlaceCellのレイアウトを設定する
    private func setupPlaceCellLayout() {
        cornerRadius = 20
        placeImageView.cornerRadius = 10
        categoryLabel.textColor = .appMain
        categoryLabel.addBorder(width: 2, color: .appMain, cornerRadius: 17.5)
    }
    
}
