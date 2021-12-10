//
//  Product.swift
//  Pittan
//
//  Created by cmStudent on 2021/12/01.
//

import Foundation
import RealmSwift

class Product: Object {
    
    // MARK: - Properties
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var imageID: String? = nil
    @objc dynamic var category: String = ""
    @objc dynamic var colorCode: String = ""
    @objc dynamic var design: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var comment: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
    
    var recommendedSize: Int {
        return height * width
    }
    
    
    // MARK: - Initialize
    convenience init(imageID: String?,
                     category: String,
                     colorCode: String,
                     design: String,
                     type: String,
                     comment: String,
                     height: Int,
                     width: Int) {
        self.init()
        self.imageID = imageID
        self.category = category
        self.colorCode = colorCode
        self.design = design
        self.type = type
        self.comment = comment
        self.height = height
        self.width = width
    }
    
    
    // MARK: - Override Methods
    override static func primaryKey() -> String? {
        return "id"
    }
}
