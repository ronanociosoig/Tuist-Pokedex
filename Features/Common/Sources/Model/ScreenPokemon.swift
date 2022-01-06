//
//  ScreenPokemon.swift
//  Common
//
//  Created by Ronan on 09/05/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

public struct ScreenPokemon {
    public init(name: String, weight: Int, height: Int, iconPath: String?) {
        self.name = name
        self.weight = weight
        self.height = height
        self.iconPath = iconPath
    }
    
    public let name: String
    public let weight: Int
    public let height: Int
    public var iconPath: String?
}
