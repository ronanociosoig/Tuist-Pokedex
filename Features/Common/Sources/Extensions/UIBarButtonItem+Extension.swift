//
//  UIBarButtonItem+Extension.swift
//  Common
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    
    /// Typealias for UIBarButtonItem closure.
    typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> Void
    
    private class UIBarButtonItemClosureWrapper: NSObject {
        let closure: UIBarButtonItemTargetClosure
        init(_ closure: @escaping UIBarButtonItemTargetClosure) {
            self.closure = closure
        }
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    var targetClosure: UIBarButtonItemTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIBarButtonItemClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIBarButtonItemClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    convenience init(title: String?, style: UIBarButtonItem.Style, closure: @escaping UIBarButtonItemTargetClosure) {
        self.init(title: title, style: style, target: nil, action: nil)
        targetClosure = closure
        action = #selector(UIBarButtonItem.closureAction)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}
