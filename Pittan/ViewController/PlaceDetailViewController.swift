//
//  PlaceDetailViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/03.
//

import UIKit

final class PlaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    /// 設置場所
    private var place: Place?
    
    
    // MARK: - @IBOutlets
    /// 実際に設置した時のイメージを表示するUIImageView
    @IBOutlet weak var imagesView: UIImageView!
    /// 設置場所の名前を表示するUILabel
    @IBOutlet private weak var nameLabel: UILabel!
    /// 設置するモノのカテゴリを表示するUILabel
    @IBOutlet private weak var categoryLabel: UILabel!
    /// 設置するモノの縦幅を表示するUILabel
    @IBOutlet private weak var heightLabel: UILabel!
    /// 設置するモノの横幅を表示するUILabel
    @IBOutlet private weak var widthLabel: UILabel!
    /// 設置場所のコメントを表示するUILabel
    @IBOutlet private weak var commentLabel: UILabel!
    /// カーテンのサイズを表示するUIStackView
    @IBOutlet private weak var curtainSizeStackView: UIStackView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        navigationController?.navigationBar.tintColor = .appText
        imagesView.cornerRadius = 10
        categoryLabel.addBorder(width: 2, color: .appMain, cornerRadius: categoryLabel.bounds.height / 2)
        curtainSizeStackView.cornerRadius = 10
        displayPlace(place)
    }
    
    /// 設置場所を表示する
    /// - Parameter place: 設置場所
    private func displayPlace(_ place: Place?) {
        guard let place = place else { return }
        nameLabel.text = place.name
        displayProduct(place)
    }
    
    /// 設置場所に置くモノを表示する
    /// - Parameter place: 設置場所
    private func displayProduct(_ place: Place) {
        guard let product = place.product else { return }
        categoryLabel.text = product.category
        heightLabel.text = "\(product.height) mm"
        widthLabel.text = "\(product.width) mm"
        commentLabel.text = product.comment
    }
    
    
    // MARK: - @IBActions
    /// 編集ボタンを押した時の処理
    @IBAction private func tappedEditButton(_ sender: UIBarButtonItem) {
        guard let place = place else { return }
        guard let addPlaceVC = storyboard?.instantiateViewController(with: AddPlaceViewController.self) else { return }
        addPlaceVC.initialize(place: place)
        addPlaceVC.modalPresentationStyle = .fullScreen
        present(addPlaceVC, animated: true)
    }
    
}
