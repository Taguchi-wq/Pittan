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
    func savePlace() {
        let place = Place(name: "リビング", deleteFlag: false)
        add(place)
    }
    
}
