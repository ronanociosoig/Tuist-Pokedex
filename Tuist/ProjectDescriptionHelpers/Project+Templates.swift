import ProjectDescription

let reverseOrganizationName = "com.sonomos"

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://tuist.io/docs/usage/helpers/

public struct LocalFramework {
    let name: String
    let path: String
    let frameworkDependancies: [TargetDependency]
    let exampleDependencies: [TargetDependency]
    let resources: [String]
    
    public init(name: String,
                path: String,
                frameworkDependancies: [TargetDependency],
                exampleDependencies: [TargetDependency],
                resources: [String]) {
        self.name = name
        self.path = path
        self.frameworkDependancies = frameworkDependancies
        self.exampleDependencies = exampleDependencies
        self.resources = resources
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
        
        let schemes = makeSchemes(targetName: name)
        
        return Project(name: name,
                       organizationName: organizationName,
                       packages: packages,
                       targets: targets,
                       schemes: schemes)
    }
    
    public static func makeAppInfoPlist() -> InfoPlist {
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
            ]
        
        return InfoPlist.extendingDefault(with: infoPlist)
    }

    /// Helper function to create a framework target and an associated unit test target
    public static func makeFrameworkTargets(localFramework: LocalFramework, platform: Platform) -> [Target] {
        let frameworkPath = "Features/\(localFramework.path)/Targets/\(localFramework.name)"
        let resources = localFramework.resources
        let resourceFilePaths = resources.map { ResourceFileElement.glob(pattern: Path("Features/\(localFramework.path)/Targets/\(localFramework.name)/" + $0), tags: [])}
        
        var exampleAppDependancies = localFramework.exampleDependencies
        exampleAppDependancies.append(.target(name: localFramework.name))
        
        let exampleAppTarget  = Target(name: "\(localFramework.name)ExampleApp",
                platform: platform,
                product: .app,
                bundleId: "\(reverseOrganizationName).\(localFramework.name)ExampleApp",
                infoPlist: makeAppInfoPlist(),
                sources: ["Features/\(localFramework.path)/Targets/Example/Sources/**"],
                resources: ["Features/\(localFramework.path)/Targets/Example/Resources/**/*",
                            "Features/\(localFramework.path)/Targets/Example/Sources/**/*.storyboard"],
                dependencies: exampleAppDependancies)
    
        let sources = Target(name: localFramework.name,
                platform: platform,
                product: .framework,
                bundleId: "\(reverseOrganizationName).\(localFramework.name)",
                infoPlist: .default,
                sources: ["\(frameworkPath)/Sources/**"],
                resources: ResourceFileElements(resources: resourceFilePaths),
                headers: Headers(public: ["\(frameworkPath)/Sources/**/*.h"]),
                dependencies: localFramework.frameworkDependancies)
        
        let tests = Target(name: "\(localFramework.name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "\(reverseOrganizationName).\(localFramework.name)Tests",
                infoPlist: .default,
                sources: ["\(frameworkPath)/Tests/**"],
                resources: [],
                dependencies: [.target(name: localFramework.name)])
    
        return [sources, tests, exampleAppTarget]
    }

    /// Helper function to create the application target and the unit test target.
    public static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(reverseOrganizationName).\(name)",
            infoPlist: makeAppInfoPlist(),
            sources: ["Features/\(name)/Targets/\(name)/Sources/**"],
            resources: ["Features/\(name)/Targets/\(name)/Resources/**"
            ],
            actions: [
                TargetAction.post(path: "scripts/swiftlint.sh", arguments: ["$TARGETNAME"], name: "SwiftLint")
            ],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(reverseOrganizationName).\(name)Tests",
            infoPlist: .default,
            sources: ["Features/\(name)/Targets/\(name)/Tests/**"],
            resources: ["Features/\(name)/Targets/\(name)/Tests/**/*.json",
                        "Features/\(name)/Targets/\(name)/Tests/**/*.png"],
            dependencies: [
                .target(name: "\(name)")
        ])
        
        let uiTestTarget = Target(
            name: "\(name)UITests",
            platform: platform,
            product: .uiTests,
            bundleId: "\(reverseOrganizationName).\(name)UITests",
            infoPlist: .default,
            sources: ["Features/\(name)/Targets/\(name)/UITests/**"],
            resources: [],
            dependencies: [
                .target(name: "\(name)")
        ])
        
        return [mainTarget, testTarget, uiTestTarget]
    }

    public static func makeSchemes(targetName: String) -> [Scheme] {
        let mainTargetReference = TargetReference(stringLiteral: targetName)
        let debugConfiguration = "Debug"
        let coverage = true
        let codeCoverageTargets: [TargetReference] = [mainTargetReference]
        let buildAction = BuildAction(targets: [mainTargetReference])
        let executable = mainTargetReference
        let networkTestingLaunchArguments = Arguments(launchArguments: [LaunchArgument(name: "Network", isEnabled: true)])
        let uiTestingLaunchArguments = Arguments(launchArguments: [LaunchArgument(name: "UITesting", isEnabled: true)])
        
        let testAction = TestAction(targets: [TestableTarget(stringLiteral: "\(targetName)UITests")],
                                    configurationName: debugConfiguration,
                                    coverage: coverage,
                                    codeCoverageTargets: codeCoverageTargets)

        let networkTestingScheme = Scheme(
            name: "\(targetName) Network Testing",
            shared: false,
            buildAction: buildAction,
            runAction: RunAction(configurationName: debugConfiguration,
                                 executable: executable,
                                 arguments: networkTestingLaunchArguments)
        )
        
        let uiTestingScheme = Scheme(
            name: "\(targetName) UITesting",
            shared: false,
            buildAction: buildAction,
            testAction: testAction,
            runAction: RunAction(configurationName: debugConfiguration,
                                 executable: executable,
                                 arguments: uiTestingLaunchArguments)
        )
        
        return [networkTestingScheme, uiTestingScheme]
    }
}
