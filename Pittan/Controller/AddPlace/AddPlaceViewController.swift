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
    var snapshot: UIImage?
    
    
    // MARK: - @IBOutlets
    /// UINavigationBar
    @IBOutlet private weak var navigationBar: UINavigationBar!
    /// 画面を閉じるボタン
    @IBOutlet private weak var closeButton: UIBarButtonItem!
    /// 入力したデータを保存するボタン
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    /// UIScrollView
    @IBOutlet private weak var addPlaceScrollView: UIScrollView!
    /// 雰囲気を見るUIImageView
    @IBOutlet private weak var imageView: UIImageView!
    /// 設置場所の名前を入力するUITextField
    @IBOutlet private weak var placeNameTextField: UITextField!
    /// 窓枠の縦幅を入力するUITextField
    @IBOutlet private weak var heightTextField: UITextField!
    /// 窓枠の横幅を入力するUITextField
    @IBOutlet private weak var widthTextField: UITextField!
    /// コメントを入力するUITextView
    @IBOutlet private weak var commentTextView: UITextView!
    /// カテゴリを選択するUISegmentedControl
    @IBOutlet private weak var categorySegmentedControl: UISegmentedControl!
    /// UIScrollViewの高さ
    @IBOutlet private weak var addPlaceScrollViewHeight: NSLayoutConstraint!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupKeyboardWill()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let snapshot = snapshot {
            imageView.cornerRadius = 10
            imageView.image = snapshot
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
        navigationBar.hideShadow(true)
        imageView.addBorder(color: .appText, cornerRadius: 10)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedImageView(_:))))
        categorySegmentedControl.setTitle(state: .selected)
        categorySegmentedControl.setTitle(state: .normal)
        commentTextView.addToolbar { self.view.endEditing(true) }
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
        imageView.image = UIImage(imagePath: product.imagePath)
        heightTextField.text = String(product.height)
        widthTextField.text = String(product.width)
        commentTextView.text = product.comment
        categorySegmentedControl.selectedCategory = category
    }
    
    /// 場所を保存する
    private func savePlace() {
        let placeName = placeNameTextField.text ?? ""
        let category = categorySegmentedControl.selectedCategory
        let height = heightTextField.text ?? ""
        let width = widthTextField.text ?? ""
        let comment = commentTextView.text ?? ""
        
        if height.isInt && width.isInt {
            do {
                guard let pngImageData = snapshot?.pngData() else { return }
                if let place = place {
                    guard let imagePath = place.product?.imagePath else { return }
                    try pngImageData.write(to: URL(string: imagePath)!)
                    RealmManager.shared.updatePlace(place.id,
                                                    name: placeName,
                                                    imagePath: imagePath,
                                                    category: category.name,
                                                    height: Int(height)!,
                                                    width: Int(width)!,
                                                    comment: comment)
                    dismiss(animated: true)
                } else if let product = product {
                    guard let filePath = createFilePathURL() else { return }
                    try pngImageData.write(to: filePath)
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
                    presentingViewController?
                        .presentingViewController?
                        .dismiss(animated: true, completion: nil)
                }
            } catch {
                print("Failed to save the snapshot.")
            }
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
    
    @objc
    private func tappedImageView(_ sender: UITapGestureRecognizer) {
        if let _ = place {
            guard let putProductVC = storyboard?.instantiateViewController(with: PutProductViewController.self) else { return }
            putProductVC.modalPresentationStyle = .fullScreen
            putProductVC.delegate = self
            present(putProductVC, animated: true)
        } else if let _ = product, let _ = snapshot {
            dismiss(animated: true)
        }
    }
    
    
    // MARK: - @IBActions
    /// closeButtonを押した時に呼ばれる
    @IBAction private func tappedCloseButton(_ sender: UIBarButtonItem) {
        if let _ = place {
            dismiss(animated: true)
        } else if let _ = product, let _ = snapshot {
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
        let commentIsEmpty = commentTextView.text?.isEmpty ?? false
        
        if placeNameIsEmpty || heightIsEmpty || widthIsEmpty || commentIsEmpty {
            Alert.showError(on: self, message: .pleaseFillAllFields)
        } else {
            savePlace()
        }
    }
    
}
