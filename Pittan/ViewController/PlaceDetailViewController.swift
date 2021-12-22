//
//  PlaceDetailViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/03.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    
    /// 設置場所
    private var place: Place?
    
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
        categoryLabel.addBorder(width: 2,
                                color: .appMain,
                                cornerRadius: categoryLabel.bounds.height/2)
        curtainSizeStackView.cornerRadius = 10
    }
    
    
    // MARK: - @IBActions
    @IBAction private func tappedEditButton(_ sender: UIBarButtonItem) {
        print("編集")
    }
    
}
