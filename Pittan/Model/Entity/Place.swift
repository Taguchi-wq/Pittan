//
//  Place.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/02.
//

import Foundation
import RealmSwift

class Place: Object {
    
    // MARK: - Properties
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var productID: String? = nil
    @objc dynamic var name: String = ""
    @objc dynamic var deleteFlag: Bool = false
    
    
    // MARK: - Initialize
    convenience init(productID: String? = nil, name: String, deleteFlag: Bool) {
        self.init()
        
        self.productID = productID
        self.name = name
        self.deleteFlag = deleteFlag
    }
    
    
    // MARK: - Override Methods
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
