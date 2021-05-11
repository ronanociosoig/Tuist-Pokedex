//
//  Log.swift
//  Network
//
//  Created by Ronan O Ciosig on 9/5/21.
//  Copyright © 2021 Sonomos.com. All rights reserved.
//

import Foundation
import os.log

struct Log {
    static var general = OSLog(subsystem: "com.sonomos.pokedex", category: "general")
    static var network = OSLog(subsystem: "com.sonomos.pokedex", category: "network")
    static var data = OSLog(subsystem: "com.sonomos.pokedex", category: "data")
}
