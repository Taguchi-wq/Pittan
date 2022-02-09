//
//  SizeSliderCell.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/18.
//

import UIKit

final class SizeSliderCell: UICollectionViewCell {
    
    // MARK: - Properties
    /// SizeSliderCellDelegate
    weak var delegate: SizeSliderCellDelegate?
    

    // MARK: - @IBOutlets
    /// nodeの縦幅を変更するUISlider
    @IBOutlet private weak var heightSlider: UISlider!
    /// nodeの横幅を変更するUISlider
    @IBOutlet private weak var widthSlider: UISlider!
    
    
    // MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    // MARK: - @IBActions
    /// heightSliderを動かした時に呼ばれる
    @IBAction private func slideHeight(_ sender: UISlider) {
        delegate?.changedHeight(sender.value)
    }
    
    /// widthSliderを動かした時に呼ばれる
    @IBAction private func slideWidth(_ sender: UISlider) {
        delegate?.changedWidth(sender.value)
    }
    
}
