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
    var selectedTexture: String?
    
    
    // MARK: - Initialize
    init(sceneView: ARSCNView) {
        self.sceneView = sceneView
        super.init()
        
        setupTapGesture()
        setupPanGesture()
        setupRotationGesture()
    }
    
    
    // MARK: - Methods
    /// タップジェスチャーを設定する
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGesture.delegate = self
        sceneView.addGestureRecognizer(tapGesture)
    }
    
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
    
    @objc
    private func didTap(_ gesture: UIPanGestureRecognizer) {
        for childNode in sceneView.scene.rootNode.childNodes {
            if childNode.name == "uploads_files_2420428_FA_Curtain_02_Default_OBJ" {
                return
            }
        }
        // 柄が選択されてない状態で画面タップ -> 何もしない
        guard let selectedTexture = selectedTexture else { return }
        
        let location = gesture.location(in: sceneView)
        guard selectedObject == nil else { return }
        guard let query = sceneView.getRaycastQuery(from: location),
              let result = sceneView.castRay(for: query).first,
              let scene = SCNScene(named: "curtain.scn"),
              let node = (scene.rootNode.childNode(withName: "uploads_files_2420428_FA_Curtain_02_Default_OBJ", recursively: false)) else { return }
        selectedObject = node
        selectedObject!.simdWorldPosition = result.worldTransform.translation
        selectedObject!.pivot = SCNMatrix4MakeTranslation(0, selectedObject!.boundingBox.min.y, 0)
        selectedObject!.scale = SCNVector3(0.05, 0.05, 0.05)
        selectedObject!.setTexture(selectedTexture)
        sceneView.scene.rootNode.addChildNode(selectedObject!)
    }
    
    @objc
    private func didPan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        switch gesture.state {
        case .began:
            let hitObject = sceneView.getHitObject(location)
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
            let hitObject = sceneView.getHitObject(location)
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
