//
//  HomeViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - @IBOutlets
    /// 設置場所追加ボタン
    @IBOutlet private weak var addPlaceButton: UIButton!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    // MARK: - @IBActions
    /// addPlaceButtonを押した時に呼ばれる
    @IBAction private func tappedAddPlaceButton(_ sender: UIButton) {
    }
    
}
