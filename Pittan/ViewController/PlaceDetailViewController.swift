//
//  PlaceDetailViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/03.
//

import UIKit

final class PlaceDetailViewController: UIViewController {

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    // MARK: - Methods
    /// 画面のレイアウトを設定する
    private func setupLayout() {
        view.backgroundColor = .appBackground
        navigationController?.navigationBar.tintColor = .appText
    }
    
    
    // MARK: - @IBActions
    @IBAction private func tappedEditButton(_ sender: UIBarButtonItem) {
        print("編集")
    }
    
}
