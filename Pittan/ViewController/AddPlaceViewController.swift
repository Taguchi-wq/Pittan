//
//  AddPlaceViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/02.
//

import UIKit

final class AddPlaceViewController: UIViewController {
    
    // MARK: - Properties
    /// 設置場所
    private var place: Place?
    
    
    // MARK: - @IBOutlets
    /// UINavigationBar
    @IBOutlet private weak var navigationBar: UINavigationBar!
    /// 画面を閉じるボタン
    @IBOutlet private weak var closeButton: UIBarButtonItem!
    /// 入力したデータを保存するボタン
    @IBOutlet private weak var saveButton: UIBarButtonItem!
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
    
    
    // MARK: - Initialize
    func initialize(place: Place) {
        self.place = place
    }
    
    
    // MARK: - Methods
    /// 画面のレイアウトを設定する
    private func setupLayout() {
        view.backgroundColor = .appBackground
        navigationBar.hideShadow(true)
        checkMoodButton.addBorder(color: .appText, cornerRadius: 10)
        categorySegmentedControl.setTitle(state: .selected)
        categorySegmentedControl.setTitle(state: .normal)
        placeNameTextField.addBottomBorder()
        heightTextField.addBottomBorder()
        widthTextField.addBottomBorder()
        commentTextField.addBottomBorder()
        inputPlace(place)
    }
    
    /// 受け取った設置場所を入力する
    /// - Parameter place: 設置場所
    private func inputPlace(_ place: Place?) {
        guard let place = place else { return }
        placeNameTextField.text = place.name
        inputProduct(place)
    }
    
    /// 受け取ったモノを入力する
    /// - Parameter place: モノ
    private func inputProduct(_ place: Place) {
        guard let product = place.product else { return }
        guard let category = Category(rawValue: product.category) else { return }
        heightTextField.text = String(product.height)
        widthTextField.text = String(product.width)
        commentTextField.text = product.comment
        categorySegmentedControl.selectedCategory = category
    }
    
    /// 場所を保存する
    private func savePlace() {
        let placeName = placeNameTextField.text ?? ""
        let comment = commentTextField.text ?? ""
        let category = categorySegmentedControl.selectedCategory
        let height = heightTextField.text ?? ""
        let width = widthTextField.text ?? ""
        
        if height.isNumber && width.isNumber {
            RealmManager.shared.savePlace(name: placeName,
                                          imageID: nil,
                                          category: category.name,
                                          colorCode: "",
                                          design: "",
                                          type: "",
                                          comment: comment,
                                          height: Int(height)!,
                                          width: Int(width)!)
            dismiss(animated: true)
        } else {
            Alert.show(on: self, message: .pleaseEnterNumber)
        }
    }
    
    
    // MARK: - @IBActions
    /// closeButtonを押した時に呼ばれる
    @IBAction private func tappedCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    /// saveButtonを押した時に呼ばれる
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
        let placeNameIsEmpty = placeNameTextField.text?.isEmpty ?? false
        let heightIsEmpty = heightTextField.text?.isEmpty ?? false
        let widthIsEmpty = widthTextField.text?.isEmpty ?? false
        let commentIsEmpty = commentTextField.text?.isEmpty ?? false
        
        if placeNameIsEmpty || heightIsEmpty || widthIsEmpty || commentIsEmpty {
            Alert.show(on: self, message: .pleaseFillAllFields)
        } else {
            savePlace()
        }
    }
    
    /// checkMoodButtonを押した時に呼ばれる
    @IBAction private func tappedCheckMoodButton(_ sender: UIButton) {
        guard let putProductVC = storyboard?.instantiateViewController(with: PutProductViewController.self) else { return }
        putProductVC.modalPresentationStyle = .fullScreen
        present(putProductVC, animated: true)
    }
    
}
