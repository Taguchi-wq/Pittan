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
    /// 製品
    private var product: Product?
    /// スナップショット
    private var snapshot: UIImage?
    
    
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
    /// UIScrollViewの高さ
    @IBOutlet private weak var addPlaceScrollViewHeight: NSLayoutConstraint!
    /// 雰囲気を見るボタンの高さ
    @IBOutlet private weak var checkMoodButtonHeight: NSLayoutConstraint!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let snapshot = snapshot {
            checkMoodButton.imageView?.contentMode = .scaleAspectFill
            checkMoodButton.imageView?.cornerRadius = 10
            checkMoodButton.setImage(snapshot, for: .normal)
            checkMoodButtonHeight.constant = 400
            addPlaceScrollViewHeight.constant += checkMoodButtonHeight.constant
        }
    }
    
    
    // MARK: - Initialize
    func initialize(place: Place) {
        self.place = place
    }
    
    func initialize(product: Product, snapshot: UIImage) {
        self.product = product
        self.snapshot = snapshot
    }
    
    
    // MARK: - Methods
    /// 画面のレイアウトを設定する
    private func setupLayout() {
        view.backgroundColor = .appBackground
        placeNameTextField.delegate = self
        heightTextField.delegate = self
        widthTextField.delegate = self
        commentTextField.delegate = self
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
        let category = categorySegmentedControl.selectedCategory
        let height = heightTextField.text ?? ""
        let width = widthTextField.text ?? ""
        let comment = commentTextField.text ?? ""
        
        if height.isInt && width.isInt {
            if let place = place {
                RealmManager.shared.updatePlace(place.id,
                                                name: placeName,
                                                category: category.name,
                                                height: Int(height)!,
                                                width: Int(width)!,
                                                comment: comment)
            } else if let product = product {
                guard let snapshot = snapshot else { return }
                guard let filePath = createFilePathURL() else { return }
                
                let pngImageData = snapshot.pngData()
                do {
                    try pngImageData?.write(to: filePath)
                    product.imagePath = filePath.absoluteString
                    RealmManager.shared.savePlace(name: placeName,
                                                  imagePath: product.imagePath,
                                                  category: category.name,
                                                  colorCode: product.colorCode,
                                                  design: product.design,
                                                  type: product.type,
                                                  comment: comment,
                                                  height: Int(height)!,
                                                  width: Int(width)!)
                } catch {
                    print("Failed to save the image")
                }
            }
            
            presentingViewController?
                .presentingViewController?
                .dismiss(animated: true, completion: nil)
        } else {
            Alert.showError(on: self, message: .pleaseEnterNumber)
        }
    }
    
    private func createFilePathURL() -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let uuid = UUID().uuidString
        return documentURL.appendingPathComponent(uuid + ".png")
    }
    
    
    // MARK: - @IBActions
    /// closeButtonを押した時に呼ばれる
    @IBAction private func tappedCloseButton(_ sender: UIBarButtonItem) {
        if let _ = product, let _ = snapshot {
            presentingViewController?
                .presentingViewController?
                .dismiss(animated: true, completion: nil)
        }
    }
    
    /// saveButtonを押した時に呼ばれる
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
        let placeNameIsEmpty = placeNameTextField.text?.isEmpty ?? false
        let heightIsEmpty = heightTextField.text?.isEmpty ?? false
        let widthIsEmpty = widthTextField.text?.isEmpty ?? false
        let commentIsEmpty = commentTextField.text?.isEmpty ?? false
        
        if placeNameIsEmpty || heightIsEmpty || widthIsEmpty || commentIsEmpty {
            Alert.showError(on: self, message: .pleaseFillAllFields)
        } else {
            savePlace()
        }
    }
    
    /// checkMoodButtonを押した時に呼ばれる
    @IBAction private func tappedCheckMoodButton(_ sender: UIButton) {
        presentingViewController?
            .presentingViewController?
            .dismiss(animated: true)
    }
    
}

extension AddPlaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
}
