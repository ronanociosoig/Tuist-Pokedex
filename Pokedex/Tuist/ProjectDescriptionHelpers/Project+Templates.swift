import ProjectDescription

let reverseOrganizationName = "com.sonomos"

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://tuist.io/docs/usage/helpers/

public struct LocalFramework {
    let name: String
    let path: String
    
    public init(name: String, path: String) {
        self.name = name
        self.path = path
    }
}

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String,
                           platform: Platform,
                           packages: [Package],
                           targetDependancies: [TargetDependency],
                           additionalTargets: [LocalFramework]) -> Project {
        
        let organizationName = "Sonomos.com"
        var dependencies = additionalTargets.map { TargetDependency.target(name: $0.name) }
        dependencies.append(contentsOf: targetDependancies)
        
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     dependencies: dependencies)
        targets += additionalTargets.flatMap({ makeFrameworkTargets(localFramework: $0, platform: platform) })
        return Project(name: name,
                       organizationName: organizationName,
                       packages: packages,
                       targets: targets)
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(localFramework: LocalFramework, platform: Platform) -> [Target] {
        let relativeFrameworkPath = "../\(localFramework.path)/Targets/\(localFramework.name)"
        let sources = Target(name: localFramework.name,
                platform: platform,
                product: .framework,
                bundleId: "\(reverseOrganizationName).\(localFramework.name)",
                infoPlist: .default,
                sources: ["\(relativeFrameworkPath)/Sources/**"],
                resources: [],
                dependencies: [])
        let tests = Target(name: "\(localFramework.name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "\(reverseOrganizationName).\(localFramework.name)Tests",
                infoPlist: .default,
                sources: ["\(relativeFrameworkPath)/Tests/**"],
                resources: [],
                dependencies: [.target(name: localFramework.name)])
        return [sources, tests]
    }

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
            ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(reverseOrganizationName).\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(reverseOrganizationName).\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
        ])
        return [mainTarget, testTarget]
    }
}
