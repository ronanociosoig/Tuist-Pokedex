import ProjectDescription

let reverseOrganizationName = "com.sonomos"

let featuresPath = "Features"
let exampleAppSuffix = "ExampleApp"
let examplePath = "Example"

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://tuist.io/docs/usage/helpers/

public enum uFeatureTarget {
    case framework
    case unitTests
    case exampleApp
}

public struct Module {
    let name: String
    let path: String
    let frameworkDependancies: [TargetDependency]
    let exampleDependencies: [TargetDependency]
    let frameworkResources: [String]
    let exampleResources: [String]
    let testResources: [String]
    let targets: Set<uFeatureTarget>
    
    public init(name: String,
                path: String,
                frameworkDependancies: [TargetDependency],
                exampleDependencies: [TargetDependency],
                frameworkResources: [String],
                exampleResources: [String],
                testResources: [String],
                targets: Set<uFeatureTarget> = Set([.framework, .unitTests, .exampleApp])) {
        self.name = name
        self.path = path
        self.frameworkDependancies = frameworkDependancies
        self.exampleDependencies = exampleDependencies
        self.frameworkResources = frameworkResources
        self.exampleResources = exampleResources
        self.testResources = testResources
        self.targets = targets
    }
}

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String,
                           platform: Platform,
                           packages: [Package],
                           targetDependancies: [TargetDependency],
                           moduleTargets: [Module]) -> Project {
        
        let organizationName = "Sonomos.com"
        var dependencies = moduleTargets.map { TargetDependency.target(name: $0.name) }
        dependencies.append(contentsOf: targetDependancies)
        
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     dependencies: dependencies)
        
        targets += moduleTargets.flatMap({ makeFrameworkTargets(module: $0, platform: platform) })
        
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
    public static func makeFrameworkTargets(module: Module, platform: Platform) -> [Target] {
        let frameworkPath = "\(featuresPath)/\(module.path)"
        
        let frameworkResourceFilePaths = module.frameworkResources.map { ResourceFileElement.glob(pattern: Path("\(featuresPath)/\(module.path)/" + $0), tags: [])}
        
        let exampleResourceFilePaths = module.exampleResources.map { ResourceFileElement.glob(pattern: Path("\(featuresPath)/\(module.path)/\(examplePath)/" + $0), tags: [])}
        
        let testResourceFilePaths = module.testResources.map { ResourceFileElement.glob(pattern: Path("\(featuresPath)/\(module.path)/Tests/" + $0), tags: [])}
        
        var exampleAppDependancies = module.exampleDependencies
        exampleAppDependancies.append(.target(name: module.name))
        
        let exampleSourcesPath = "\(featuresPath)/\(module.path)/\(examplePath)/Sources"
        
        var targets = [Target]()
        
        if module.targets.contains(.exampleApp) {
            targets.append(Target(name: "\(module.name)\(exampleAppSuffix)",
                    platform: platform,
                    product: .app,
                    bundleId: "\(reverseOrganizationName).\(module.name)\(exampleAppSuffix)",
                    infoPlist: makeAppInfoPlist(),
                    sources: ["\(exampleSourcesPath)/**"],
                    resources: ResourceFileElements(resources: exampleResourceFilePaths),
                    dependencies: exampleAppDependancies))
        }
    
        if module.targets.contains(.framework) {
            targets.append(Target(name: module.name,
                    platform: platform,
                    product: .framework,
                    bundleId: "\(reverseOrganizationName).\(module.name)",
                    infoPlist: .default,
                    sources: ["\(frameworkPath)/Sources/**"],
                    resources: ResourceFileElements(resources: frameworkResourceFilePaths),
                    headers: Headers(public: ["\(frameworkPath)/Sources/**/*.h"]),
                    dependencies: module.frameworkDependancies))
        }

        if module.targets.contains(.unitTests) {
            targets.append(Target(name: "\(module.name)Tests",
                    platform: platform,
                    product: .unitTests,
                    bundleId: "\(reverseOrganizationName).\(module.name)Tests",
                    infoPlist: .default,
                    sources: ["\(frameworkPath)/Tests/**"],
                    resources: ResourceFileElements(resources: testResourceFilePaths),
                    dependencies: [.target(name: module.name)]))
        }

        return targets
    }

    /// Helper function to create the application target and the unit test target.
    public static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(reverseOrganizationName).\(name)",
            infoPlist: makeAppInfoPlist(),
            sources: ["\(featuresPath)/\(name)/Sources/**"],
            resources: ["\(featuresPath)/\(name)/Resources/**"
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
            sources: ["\(featuresPath)/\(name)/Tests/**"],
            resources: ["\(featuresPath)/\(name)/Tests/**/*.json",
                        "\(featuresPath)/\(name)/Tests/**/*.png"],
            dependencies: [
                .target(name: "\(name)")
        ])
        
        let uiTestTarget = Target(
            name: "\(name)UITests",
            platform: platform,
            product: .uiTests,
            bundleId: "\(reverseOrganizationName).\(name)UITests",
            infoPlist: .default,
            sources: ["\(featuresPath)/\(name)/UITests/**"],
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
