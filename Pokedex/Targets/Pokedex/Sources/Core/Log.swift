//
//  Log.swift
//  PokedexCommon
//
//  Created by Ronan O Ciosig on 5/6/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation
import os.log

public struct Log {
    public static var general = OSLog(subsystem: "com.sonomos.pokedex", category: "general")
    public static var network = OSLog(subsystem: "com.sonomos.pokedex", category: "network")
    public static var data = OSLog(subsystem: "com.sonomos.pokedex", category: "data")
}
