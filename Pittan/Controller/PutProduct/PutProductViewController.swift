//
//  PutProductViewController.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/09.
//

import UIKit
import ARKit
import JonContextMenu

final class PutProductViewController: UIViewController, ARSessionDelegate {
    
    // MARK: - Enums
    enum Section: CaseIterable {
        case tag
        case product
    }
    
    
    // MARK: - Properties
    /// PutProductViewControllerDelegate
    weak var delegate: PutProductViewControllerDelegate?
    /// 選ばれているtag
    var selectTag: Tag = .put
    /// 選択されている製品
    var selectedProduct: ProductKind?
    /// 3Dオブジェクトに対してのジェスチャーをつける
    lazy var objectInteraction = ObjectInteraction(sceneView: sceneView)
    /// 作成した製品
    private var product = Product()
    /// スナップショット
    private var snapshot: UIImage?
    /// スナップショットを表示するbackView
    private let backView = UIView()
    /// コーチング
    private var coachingOverlay: ARCoachingOverlayView?
    /// カーソル
    private let focusSquare = FocusSquare()
    /// カーソルキュー
    private let updateQueue = DispatchQueue(label: "focusSquareQueue")
    /// 柄
    private let patterns: [JonItem] = PatternKind.allCases.enumerated().map {
        JonItem(id: $0.0, title: $0.1.name, icon: UIImage(named: $0.1.imageName))
    }
    

    // MARK: - @IBOutlets
    /// sceneView
    @IBOutlet weak var sceneView: ARSCNView!
    /// 製品を選ぶUICollectionView
    @IBOutlet weak var putProductCollectionView: UICollectionView!
    /// 閉じるボタン
    @IBOutlet private weak var backButton: UIButton!
    /// 削除ボタン
    @IBOutlet private weak var removeButton: UIButton!
    /// シャッターボタン
    @IBOutlet private weak var shutterButton: UIButton!
    /// メッセージを表示するUILabel
    @IBOutlet private weak var arMessageLabel: UILabel!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupSceneView()
        coachingOverlay = setupCoachingOverlay(.horizontalPlane)
        setupJonContextMenu()
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
        shutterButton.imageView?.tintColor = .white
        arMessageLabel.alpha = 0
        arMessageLabel.cornerRadius = 16
        arMessageLabel.clipsToBounds = true
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
        sceneView.delegate = self
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
    
    /// Pinterest風長押しジェスチャーを設定する
    private func setupJonContextMenu() {
        let contextMenu = JonContextMenu()
            .setItems(patterns)
            .setItemsActiveColorTo(.white)
            .setItemsTitleColorTo(.white)
            .setItemsTitleSizeTo(40)
            .setDelegate(self)
            .build()
        sceneView.addGestureRecognizer(contextMenu)
    }
    
    /// カーソルを更新する
    private func updateFocusSquare(isObjectVisible: Bool) {
        guard let coachingOverlay = coachingOverlay else { return }
        if isObjectVisible || coachingOverlay.isActive {
            focusSquare.hide()
            arMessageLabel.alpha = 0
        } else {
            focusSquare.unhide()
            if let camera = sceneView.session.currentFrame?.camera,
               case .normal = camera.trackingState,
               let query = sceneView.getRaycastQuery(from: sceneView.screenCenter),
               let result = sceneView.castRay(for: query).first {
                
                updateQueue.async {
                    self.focusSquare.isHidden = false
                    self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                    self.focusSquare.state = .detecting(raycastResult: result, camera: camera)
                }
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    self.arMessageLabel.alpha = 0
                }
            } else {
                updateQueue.async {
                    self.focusSquare.state = .initializing
                    self.focusSquare.isHidden = true
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                            self.arMessageLabel.alpha = 1
                        }
                    }
                }
            }
        }
    }
    
    /// AddImageButtonを押した時の処理
    @objc
    private func tappedAddImageButton(_ sender: UIButton) {
        guard let object = objectInteraction.selectedObject else { return }
        let height = object.millimeterHeight
        let width = object.millimeterWidth
        Alert.showSize(on: self, height: height, width: width) { _ in
            guard let snapshot = self.snapshot else { return }
            if let delegate = self.delegate {
                delegate.putProductViewController(snapshot: snapshot)
                delegate.putProductViewController(height: height, width: width)
                self.dismiss(animated: true)
            } else {
                guard let addPlaceVC = self.storyboard?.instantiateViewController(with: AddPlaceViewController.self) else { return }
                self.product.height = height
                self.product.width = width
                addPlaceVC.modalPresentationStyle = .fullScreen
                addPlaceVC.initialize(product: self.product, snapshot: snapshot)
                self.present(addPlaceVC, animated: true) {
                    self.backView.removeFromSuperview()
                }
            }
        }
    }
    
    /// スナップショットを撮り直す
    @objc
    private func resnapshot(_ sender: UIButton) {
        backView.removeFromSuperview()
        trackingConfiguration()
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
        selectedProduct = nil
        objectInteraction.isObjectVisible = false
        putProductCollectionView.reloadData()
    }
    
    /// shutterボタンを押した時の処理
    @IBAction private func tappedShutterButton(_ sender: UIButton) {
        snapshot = sceneView.snapshot()
        
        let screen = UIScreen.main.bounds
        
        backView.frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
        backView.backgroundColor = .appBackground
        view.addSubview(backView)
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height - 80)
        imageView.image = snapshot
        imageView.contentMode = .scaleAspectFit
        backView.addSubview(imageView)
        
        let addButton = UIButton()
        addButton.frame = CGRect(x: (screen.width/2) - (150/2), y: screen.height - 120, width: 150, height: 70)
        addButton.backgroundColor = .appMain
        addButton.setTitle("追加", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        addButton.cornerRadius = 20
        addButton.addTarget(self, action: #selector(tappedAddImageButton(_:)), for: .touchUpInside)
        backView.addSubview(addButton)
        
        let config = UIImage.SymbolConfiguration(pointSize: 32, weight: .medium, scale: .default)
        let resnapshotButton = UIButton()
        resnapshotButton.frame = CGRect(x: 15, y: screen.height - 120, width: 70, height: 70)
        resnapshotButton.setImage(UIImage(systemName: "arrow.uturn.backward", withConfiguration: config),
                                  for: .normal)
        resnapshotButton.tintColor = .appText
        resnapshotButton.addTarget(self, action: #selector(resnapshot(_:)), for: .touchUpInside)
        backView.addSubview(resnapshotButton)
        
        sceneView.session.pause()
    }
    
}

// MARK: - ARSCNViewDelegate
extension PutProductViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.updateFocusSquare(isObjectVisible: self.objectInteraction.isObjectVisible)
        }
    }
}
