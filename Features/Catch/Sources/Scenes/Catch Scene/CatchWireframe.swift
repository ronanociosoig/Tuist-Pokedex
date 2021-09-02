//
//  CatchWireframe.swift
//  CatchUI
//
//  Created by Ronan on 01/07/21.
//  Copyright © 2021 Sonomos. All rights reserved.
//

import UIKit

public class CatchWireframe {
    
    public static func makeViewController() -> CatchViewController {
        let storyboard = UIStoryboard.init(name: "CatchViewController", bundle: Bundle(for: CatchViewController.self))
        return CatchViewController.instantiateFromStoryboard(storyboard: storyboard)
    }
    
    public static func prepare(_ viewController: CatchViewController,
                        actions: CatchActions,
                        dataProvider: CatchDataProvider) {
    	let presenter =  CatchPresenter(view: viewController,
                                        actions: actions,
                                        dataProvider: dataProvider)
        viewController.presenter = presenter
    }
    
}
