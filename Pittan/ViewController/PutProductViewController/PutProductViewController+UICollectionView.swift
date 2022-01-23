//
//  PutProductViewController+UICollectionView.swift
//  Pittan
//
//  Created by cmStudent on 2022/01/21.
//

import UIKit
import SceneKit

// MARK: - UICollectionViewDataSource
extension PutProductViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        switch section {
        case .tag: return Tag.allCases.count
        case .product: return selectTag == .put ? Products.allCases.count : 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .tag:
            let tagCell = collectionView.reusableCell(with: TagCell.self, for: indexPath)
            let tag = Tag.allCases[indexPath.item]
            if tag == selectTag {
                tagCell.initialize(title: tag.japanese, textColor: .appMain)
            } else {
                tagCell.initialize(title: tag.japanese)
            }
            return tagCell
        case .product:
            if selectTag == .put {
                let productCell = collectionView.reusableCell(with: ProductCell.self, for: indexPath)
                let product = Products.allCases[indexPath.item]
                productCell.initialize(imageName: product.imageName, name: product.name)
                return productCell
            } else {
                let sizeSliderCell = collectionView.reusableCell(with: SizeSliderCell.self, for: indexPath)
                sizeSliderCell.delegate = self
                return sizeSliderCell
            }
        }
    }
    
}


// MARK: - UICollectionViewDelegate
extension PutProductViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        switch section {
        case .tag:
            selectTag = .allCases[indexPath.item]
            putProductCollectionView.reloadData()
        case .product:
            let product = Products.allCases[indexPath.item]
            guard objectInteraction.selectedObject == nil else {
                let materials = objectInteraction.selectedObject!.geometry!.materials
                for material in materials where material.name == "Default_OBJ" {
                    material.diffuse.contents = UIImage(named: product.imageName)
                    material.roughness.contents = 1
                }
                return
            }
            guard let query = sceneView.getRaycastQuery(from: sceneView.screenCenter),
                  let result = sceneView.castRay(for: query).first,
                  let scene = SCNScene(named: "curtain.scn"),
                  let node = (scene.rootNode.childNode(withName: "uploads_files_2420428_FA_Curtain_02_Default_OBJ", recursively: false)) else { return }
            objectInteraction.selectedObject = node
            objectInteraction.selectedObject?.simdWorldPosition = result.worldTransform.translation
            objectInteraction.selectedObject?.pivot = SCNMatrix4MakeTranslation(0, objectInteraction.selectedObject!.boundingBox.min.y, 0)
            objectInteraction.selectedObject?.scale = SCNVector3(0.05, 0.05, 0.05)
            
            let materials = objectInteraction.selectedObject!.geometry!.materials
            for material in materials where material.name == "Default_OBJ" {
                material.diffuse.contents = UIImage(named: product.imageName)
                material.roughness.contents = 1
            }
            
            sceneView.scene.rootNode.addChildNode(objectInteraction.selectedObject!)
        }
    }
    
}
