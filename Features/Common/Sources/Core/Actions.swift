//
//  Actions.swift
//  Common
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

public class Actions {
    public let coordinator: Coordinating
    public var dataProvider: DataProviding?
    
    public init(coordinator: Coordinating) {
        self.coordinator = coordinator
    }
}
