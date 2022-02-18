//
//  ObjectInteraction.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/20.
//

import Foundation
import ARKit

class ObjectInteraction: NSObject, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    /// SceneView
    private let sceneView: ARSCNView
    /// 選択された3Dモデル
    var selectedObject: SCNNode?
    /// 選択された柄
    var selectedPattern = "beige"
    /// 3Dモデルが表示されているかどうか
    var isObjectVisible = false
    
    
    // MARK: - Initialize
    init(sceneView: ARSCNView) {
        self.sceneView = sceneView
        super.init()
        
        setupPanGesture()
        setupRotationGesture()
    }
    
    
    // MARK: - Methods
    /// ドラッグジェスチャーを設定する
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        panGesture.delegate = self
        sceneView.addGestureRecognizer(panGesture)
    }
    
    /// 回転ジェスチャーを設定する
    private func setupRotationGesture() {
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(_:)))
        rotationGesture.delegate = self
        sceneView.addGestureRecognizer(rotationGesture)
    }
    
    /// 製品を設置する
    /// - Parameter product: 製品
    func putProduct(_ product: ProductKind) {
        guard let selectedObject = selectedObject else {
            guard let query = sceneView.getRaycastQuery(from: sceneView.screenCenter),
                  let result = sceneView.castRay(for: query).first,
                  let scene = SCNScene(named: product.sceneName),
                  let node = (scene.rootNode.childNode(withName: product.material, recursively: false)) else { return }
            selectedObject = node
            selectedObject!.simdWorldPosition = result.worldTransform.translation
            selectedObject!.pivot = SCNMatrix4MakeTranslation(0, selectedObject!.boundingBox.min.y, 0)
            selectedObject!.scale = SCNVector3(0.05, 0.05, 0.05)
            if let camera = sceneView.pointOfView {
                selectedObject!.eulerAngles.y = camera.eulerAngles.y
            }
            sceneView.scene.rootNode.addChildNode(selectedObject!)
            isObjectVisible = true
            return
        }
        
        guard selectedObject.name != product.material else { return }
        guard let scene = SCNScene(named: product.sceneName),
              let node = (scene.rootNode.childNode(withName: product.material, recursively: false)) else { return }
        
        let object = selectedObject
        
        selectedObject.removeFromParentNode()
        sceneView.scene.rootNode.removeFromParentNode()
        self.selectedObject = nil
        
        self.selectedObject = node
        self.selectedObject!.simdWorldPosition = object.simdWorldPosition
        self.selectedObject!.pivot = object.pivot
        self.selectedObject!.scale = object.scale
        self.selectedObject!.eulerAngles.y = object.eulerAngles.y
        sceneView.scene.rootNode.addChildNode(self.selectedObject!)
        isObjectVisible = true
    }
    
    /// 柄を設定する
    /// - Parameter pattern: 柄
    func setPattern(_ pattern: String? = nil) {
        guard let selectedObject = selectedObject else { return }
        self.selectedPattern = pattern ?? selectedPattern
        selectedObject.setTexture(pattern ?? selectedPattern)
    }
    
    @objc
    private func didPan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        switch gesture.state {
        case .began:
            guard let hitObject = sceneView.getHitObject(location) else { return }
            selectedObject = hitObject
        case .changed:
            guard let query = sceneView.getRaycastQuery(from: location),
                  let result = sceneView.castRay(for: query).first,
                  let selectedObject = selectedObject else { return }
            selectedObject.simdWorldPosition = result.worldTransform.translation
            selectedObject.pivot = SCNMatrix4MakeTranslation(0, selectedObject.boundingBox.min.y, 0)
        default:
            return
        }
    }
    
    @objc
    private func didRotate(_ gesture: UIRotationGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        switch gesture.state {
        case .began:
            guard let hitObject = sceneView.getHitObject(location) else { return }
            selectedObject = hitObject
        case .changed:
            guard let selectedObject = selectedObject else { return }
            selectedObject.eulerAngles.y -= Float(gesture.rotation)
            gesture.rotation = 0
        default:
            return
        }
    }
    
}
