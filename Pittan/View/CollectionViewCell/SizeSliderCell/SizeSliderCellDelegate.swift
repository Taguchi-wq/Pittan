//
//  SizeSliderCellDelegate.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/21.
//

import Foundation

public protocol SizeSliderCellDelegate: AnyObject {
    func changedHeight(_ value: Float)
    func changedWidth(_ value: Float)
}
