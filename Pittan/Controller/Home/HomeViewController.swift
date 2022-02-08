//
//  HomeViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/11/30.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    /// 画面サイズ
    let screen = UIScreen.main.bounds
    /// セントラルお姉さん
    let centralWoman = UIImageView(appImage: .centralWoman)
    /// 場所を格納する配列
    var places = RealmManager.shared.fetch(Place.self)
    
    
    // MARK: - @IBOutlets
    /// 設置場所を表示するUICollectionView
    @IBOutlet private weak var placeCollectionView: UICollectionView!
    /// 設置場所追加ボタン
    @IBOutlet private weak var addPlaceButton: UIButton!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        placeCollectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    // MARK: - Methods
    /// 画面のレイアウトを設定する
    private func setupLayout() {
        view.backgroundColor = .appBackground
        placeCollectionView.dataSource = self
        placeCollectionView.delegate = self
        placeCollectionView.register(cellType: PlaceCell.self)
        placeCollectionView.collectionViewLayout = createLayout()
        placeCollectionView.backgroundColor = .clear
        addPlaceButton.cornerRadius = 16
        addPlaceButton.backgroundColor = .appMain
        addPlaceButton.addShadow()
    }
    
    
    // MARK: - @IBActions
    /// addPlaceButtonを押した時に呼ばれる
    @IBAction private func tappedAddPlaceButton(_ sender: UIButton) {
        guard let putProductVC = storyboard?.instantiateViewController(with: PutProductViewController.self) else { return }
        putProductVC.modalPresentationStyle = .fullScreen
        present(putProductVC, animated: true)
    }
    
}
