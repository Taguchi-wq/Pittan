//
//  PlaceCell.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

class PlaceCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    // MARK: - Initialize
    func initialize(place: Place) {
        placeImageView.image  = UIImage(named: place.imageName)
        placeNameLabel.text   = place.name
        placeHeightLabel.text = "\(place.height)"
        placeWidthLabel.text  = "\(place.width)"
        categoryLabel.text    = place.category
    }

}
