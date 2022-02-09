//
//  UIBarButtonItem+Extension.swift
//  Pittan
//
//  Created by cmStudent on 2022/02/08.
//

import UIKit

private var actionKey: Void?

public extension UIBarButtonItem {
    
    typealias Method = () -> ()
    
    private var action: Method {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! Method
        }
        set {
            objc_setAssociatedObject(self,
                                     &actionKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    convenience init(title: String?, style: UIBarButtonItem.Style, action: @escaping Method) {
        self.init(title: title, style: style, target: nil, action: #selector(pressed(_:)))
        self.target = self
        self.action = action
    }
    
    @objc
    private func pressed(_ sender: UIBarButtonItem) {
        action()
    }
    
}
