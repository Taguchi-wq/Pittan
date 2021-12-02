//
//  ProductImage.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/02.
//

import Foundation
import RealmSwift

class ProductImage: Object {
    
    // MARK: - Properties
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var path: String = ""
    
    
    // MARK: - Initialize
    convenience init(path: String) {
        self.init()
        
        self.path = path
    }
    
    
    // MARK: - Override Methods
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
