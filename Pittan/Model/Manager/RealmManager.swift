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
    ///   - imageID: 画像id
    ///   - category: カテゴリー(カーテンorラグ)
    ///   - colorCode: 製品の色
    ///   - design: 柄
    ///   - type: 片開、両開き...
    ///   - comment: コメント
    ///   - height: 製品の縦幅
    ///   - width: 製品の横幅
    func savePlace(name: String,
                   imageID: String?,
                   category: String,
                   colorCode: String,
                   design: String,
                   type: String,
                   comment: String,
                   height: Int,
                   width: Int) {
        let product = Product(imageID: imageID,
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
    
    /// 製品をidで取得する
    /// - Parameter id: 製品のid
    /// - Returns: 製品
    func fetchProduct(by id: String) -> Product? {
        let product = realm.object(ofType: Product.self, forPrimaryKey: id)
        return product
    }
    
}
