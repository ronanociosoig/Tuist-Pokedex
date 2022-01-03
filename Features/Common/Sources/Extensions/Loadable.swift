//
//  Loadable.swift
//  Common
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

/// Lodable protocol to load from nib
public protocol Loadable { }

extension UIView: Loadable { }

/// Loadbale to laod nib from file
public extension Loadable where Self: UIView {
    
    /**
     load `UIView` from xib
     
     - Parameters:
     - frame: CGRect default = nil
     - bundle: default = Bundle.main
     */
    static func loadFromNib(withFrame frame: CGRect? = nil, bundle: Bundle = Bundle(for: Self.self)) -> Self? {
        guard let view = bundle.loadNibNamed(staticIdentifier, owner: nil, options: nil)?.last as? Self else { return nil }
        view.frame = frame ?? view.frame
        return view
    }
    
    private static var staticIdentifier: String {
        return String(describing: self)
    }
}
