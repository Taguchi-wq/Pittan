//
//  PutProductViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/09.
//

import UIKit
import ARKit

final class PutProductViewController: UIViewController, ARSessionDelegate {
    
    // MARK: - Enums
    enum Section: CaseIterable {
        case tag
        case product
    }
    
    enum Products: CaseIterable {
        case beige, brown, gray, navy, rose, turquoiseBlue, yellowgreen
        
        var imageName: String {
            switch self {
            case .beige: return "beige"
            case .brown: return "brown"
            case .gray: return "gray"
            case .navy: return "navy"
            case .rose: return "rose"
            case .turquoiseBlue: return "turquoise_blue"
            case .yellowgreen: return "yellowgreen"
            }
        }
        
        var name: String {
            switch self {
            case .beige: return "ベージュ"
            case .brown: return "ブラウン"
            case .gray: return "グレー"
            case .navy: return "ネイビー"
            case .rose: return "ローズ"
            case .turquoiseBlue: return "ターコイズブルー"
            case .yellowgreen: return "イエローグリーン"
            }
        }
    }
    
    
    // MARK: - Properties
    /// 選ばれているtag
    var selectTag: Tag = .put
    /// 3Dオブジェクトに対してのジェスチャーをつける
    lazy var objectInteraction = ObjectInteraction(sceneView: sceneView)
    /// 作成した製品
    private var product = Product()
    /// スナップショット
    private var snapshot: UIImage?
    

    // MARK: - @IBOutlets
    /// sceneView
    @IBOutlet weak var sceneView: ARSCNView!
    /// 製品を選ぶUICollectionView
    @IBOutlet weak var putProductCollectionView: UICollectionView!
    /// 閉じるボタン
    @IBOutlet private weak var backButton: UIButton!
    /// 削除ボタン
    @IBOutlet private weak var removeButton: UIButton!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupSceneView()
        setupCoachingOverlay(.horizontalPlane)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        trackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }
    
    
    // MARK: - Methods
    /// レイアウトを設定する
    private func setupLayout() {
        backButton.cornerRadius = 16
        removeButton.cornerRadius = 16
        putProductCollectionView.dataSource = self
        putProductCollectionView.delegate = self
        putProductCollectionView.register(cellType: ProductCell.self, bundle: nil)
        putProductCollectionView.register(cellType: TagCell.self, bundle: nil)
        putProductCollectionView.register(cellType: SizeSliderCell.self, bundle: nil)
        putProductCollectionView.collectionViewLayout = createLayout()
        putProductCollectionView.isScrollEnabled = false
    }
    
    /// SceneViewを設定する
    private func setupSceneView() {
        sceneView.session.delegate = self
        sceneView.scene = SCNScene()
        sceneView.pointOfView?.addChildNode(DirectionalLightNode())
    }
    
    /// トラッキング
    private func trackingConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.frameSemantics = [.personSegmentationWithDepth]
        sceneView.session.run(configuration)
    }
    
    /// AddImageButtonを押した時の処理
    @objc
    private func tappedAddImageButton(_ sender: UIButton) {
        Alert.showSize(on: self, height: 1000, width: 2000) { _ in
            guard let snapshot = self.snapshot else { return }
            guard let addPlaceVC = self.storyboard?.instantiateViewController(with: AddPlaceViewController.self) else { return }
            addPlaceVC.modalPresentationStyle = .fullScreen
            addPlaceVC.initialize(product: self.product, snapshot: snapshot)
            self.present(addPlaceVC, animated: true)
        }
    }
    
    
    // MARK: - @IBActions
    /// backボタンを押した時の処理
    @IBAction private func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    /// removeボタンを押した時の処理
    @IBAction private func tappedRemoveButton(_ sender: UIButton) {
        objectInteraction.selectedObject?.removeFromParentNode()
        sceneView.scene.rootNode.removeFromParentNode()
        objectInteraction.selectedObject = nil
    }
    
    /// shutterボタンを押した時の処理
    @IBAction private func tappedShutterButton(_ sender: UIButton) {
        snapshot = sceneView.snapshot()
        
        let uiview = UIView()
        uiview.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        uiview.backgroundColor = .appBackground
        view.addSubview(uiview)
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        imageView.image = snapshot
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let button = UIButton()
        button.frame = CGRect(x: (view.bounds.width/2) - (170/2), y: view.bounds.height - 120, width: 170, height: 70)
        button.backgroundColor = .appMain
        button.setTitle("追加", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.cornerRadius = 20
        button.addTarget(self, action: #selector(tappedAddImageButton(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        sceneView.session.pause()
    }
    
}
