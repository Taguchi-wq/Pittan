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
    /// UIScrollView
    @IBOutlet private weak var addPlaceScrollView: UIScrollView!
    /// 雰囲気を見るボタン
    @IBOutlet private weak var checkMoodButton: UIButton!
    /// 設置場所の名前を入力するUITextField
    @IBOutlet private weak var placeNameTextField: UITextField!
    /// 窓枠の縦幅を入力するUITextField
    @IBOutlet private weak var heightTextField: UITextField!
    /// 窓枠の横幅を入力するUITextField
    @IBOutlet private weak var widthTextField: UITextField!
    /// コメントを入力するUITextField
    @IBOutlet private weak var commentTextField: UITextField!
    /// カテゴリを選択するUISegmentedControl
    @IBOutlet private weak var categorySegmentedControl: UISegmentedControl!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    
    // MARK: - Methods
    private func setupLayout() {
        view.backgroundColor = .appBackground
        checkMoodButton.addBorder(color: .appText, cornerRadius: 10)
    }
    
    
    // MARK: - @IBActions
    /// closeButtonを押した時に呼ばれる
    @IBAction private func tappedCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    /// saveButtonを押した時に呼ばれる
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {}
    
}
