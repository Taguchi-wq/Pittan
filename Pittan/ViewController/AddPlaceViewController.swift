//
//  AddPlaceViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/02.
//

import UIKit

final class AddPlaceViewController: UIViewController {
    
    // MARK: - Properties
    /// 画面を閉じるボタン
    @IBOutlet private weak var closeButton: UIBarButtonItem!
    /// 入力したデータを保存するボタン
    @IBOutlet private weak var saveButton: UINavigationItem!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - @IBActions
    /// closeButtonを押した時に呼ばれる
    @IBAction private func tappedCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    /// saveButtonを押した時に呼ばれる
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {}
    
}
