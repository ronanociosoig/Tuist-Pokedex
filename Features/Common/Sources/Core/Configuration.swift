//
//  Configuration.swift
//  Common
//
//  Created by Ronan on 09/02/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

public struct Configuration {
    
    public static var uiTesting: Bool {
        let arguments = ProcessInfo.processInfo.arguments
        return arguments.contains("UITesting")
    }
    
    public static var networkTesting: Bool {
        let arguments = CommandLine.arguments
        return arguments.contains("NetworkTesting")
    }
    
    public static var searchErrorTesting: Bool {
        return CommandLine.arguments.contains("Error_401")
    }
    
    public static var asyncTesting: Bool {
        let arguments = ProcessInfo.processInfo.arguments
        return arguments.contains("AsyncTesting")
    }
}
