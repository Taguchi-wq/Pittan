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
        trackingConfiguration()
        setupCoachingOverlay(.horizontalPlane)
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
        let snapshotImage = sceneView.snapshot()
        UIImageWriteToSavedPhotosAlbum(snapshotImage, self, #selector(showResultOfSaveImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    private func showResultOfSaveImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        
        var title = "Completed"
        var message = "Completed to save on Liblary"
        
        if error != nil {
            title = "Error"
            message = "Fail to save"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler:{
            (action:UIAlertAction!) -> Void in
            print("save")
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
