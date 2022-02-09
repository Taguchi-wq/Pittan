//
//  TagCell.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/17.
//

import UIKit

final class TagCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    
    // MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Initialize
    func initialize(title: String, textColor: UIColor = .appText2) {
        titleLabel.text = title
        titleLabel.textColor = textColor
    }

}
