//
//  RealmManager.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/01.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    // MARK: - Properties
    /// RealmManagerのshared
    static let shared = RealmManager()
    /// Realmのインスタンス
    private let realm = try! Realm()
    
    
    // MARK: - Initialize
    private init() {}
    
    
    // MARK: - Methods
    /// ローカルDBにデータを追加する
    private func add<T: Object>(_ object: T) {
        do {
            try realm.write { realm.add(object) }
        } catch {
            print(error)
        }
    }
    
    /// ローカルDBに保存されているデータを取得する
    /// - Returns: データ
    func fetch<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(object)
    }
    
    /// 設置場所を保存する
    /// - Parameters:
    ///   - name: 設置場所名
    ///   - imagePath: 画像パス
    ///   - category: カテゴリー(カーテンorラグ)
    ///   - colorCode: 製品の色
    ///   - design: 柄
    ///   - type: 片開、両開き...
    ///   - comment: コメント
    ///   - height: 製品の縦幅
    ///   - width: 製品の横幅
    func savePlace(name: String,
                   imagePath: String?,
                   category: String,
                   colorCode: String,
                   design: String,
                   type: String,
                   comment: String,
                   height: Int,
                   width: Int) {
        let product = Product(imagePath: imagePath,
                              category: category,
                              colorCode: colorCode,
                              design: design,
                              type: type,
                              comment: comment,
                              height: height,
                              width: width)
        let place = Place(productID: product.id, name: name, deleteFlag: false)
        add(product)
        add(place)
    }
    
    /// 設置場所をidで取得する
    /// - Parameter id: 設置場所のid
    /// - Returns: 設置場所
    func fetchPlace(by id: String) -> Place? {
        let place = realm.object(ofType: Place.self, forPrimaryKey: id)
        return place
    }
    
    /// モノをidで取得する
    /// - Parameter id: モノのid
    /// - Returns: モノ
    func fetchProduct(by id: String) -> Product? {
        let product = realm.object(ofType: Product.self, forPrimaryKey: id)
        return product
    }
    
    /// 設置場所のデータを更新する
    /// - Parameters:
    ///   - id: 設置場所のid
    ///   - name: 設置場所の名前
    ///   - category: モノのカテゴリ
    ///   - height: モノの縦幅
    ///   - width: モノの横幅
    ///   - comment: 設置場所のコメント
    func updatePlace(_ id: String,
                     name: String,
                     imagePath: String,
                     category: String,
                     height: Int,
                     width: Int,
                     comment: String) {
        guard let place = fetchPlace(by: id) else { return }
        guard let product = place.product else { return }
        do {
            try realm.write {
                place.name = name
                product.imagePath = imagePath
                product.category = category
                product.height = height
                product.width = width
                product.comment  = comment
            }
        } catch {
            print(error)
        }
    }
    
    /// 製品のサイズを更新する
    /// - Parameters:
    ///   - id: 製品のid
    ///   - height: 縦幅
    ///   - width: 横幅
    func updateSize(_ id: String, height: Int, width: Int) {
        guard let product = fetchProduct(by: id) else { return }
        do {
            try realm.write {
                product.height = height
                product.width = width
            }
        } catch {
            print(error)
        }
    }
    
    /// 製品の画像を更新する
    /// - Parameters:
    ///   - id: 製品のid
    ///   - imagePath: 画像パス
    func updateImage(_ id: String, imagePath: String) {
        guard let product = fetchProduct(by: id) else { return }
        do {
            try realm.write { product.imagePath = imagePath }
        } catch {
            print(error)
        }
    }
    
    /// 設置場所と製品を削除する
    /// - Parameter id: 設置場所のid
    func deletePlace(_ id: String) {
        guard let place = fetchPlace(by: id) else { return }
        guard let product = place.product else { return }
        do {
            try realm.write {
                realm.delete(place)
                realm.delete(product)
            }
        } catch {
            
        }
    }
    
}
