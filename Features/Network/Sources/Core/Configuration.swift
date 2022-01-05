//
//  Configuration.swift
//  NetworkKit
//
//  Created by Ronan on 09/02/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

struct Configuration {
    
    static var uiTesting: Bool {
        let arguments = ProcessInfo.processInfo.arguments
        return arguments.contains("UITesting")
    }
    
    static var networkTesting: Bool {
        return CommandLine.arguments.contains("NetworkTesting")
    }
    
    static var searchErrorTesting: Bool {
        return CommandLine.arguments.contains("Error_401")
    }
}
