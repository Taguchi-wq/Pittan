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
        placeImageView.image  = UIImage(named: place.imageName)
        placeNameLabel.text   = place.name
        placeHeightLabel.text = "\(place.height) mm"
        placeWidthLabel.text  = "\(place.width) mm"
        categoryLabel.text    = place.category
    }

    
    // MARK: - Methods
    /// PlaceCellのレイアウトを設定する
    private func setupPlaceCellLayout() {
        layer.cornerRadius = 20
        setupImageView(placeImageView)
        categoryLabel.textColor = .appMain
    }
    
    /// UIImageViewを設定する
    /// - Parameter imageView: 設定するUIImageView
    private func setupImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = 10
    }
    
}
