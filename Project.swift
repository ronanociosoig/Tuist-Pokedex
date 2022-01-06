import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "Pokedex",
                          platform: .iOS,
                          packages: [
                            .package(url: "https://github.com/JonasGessner/JGProgressHUD", .upToNextMajor(from: "2.0.0"))
                          ],
                          targetDependancies: [
                            .package(product: "JGProgressHUD")],
                          moduleTargets: [makeHanekeModule(),
                                          makeHomeModule(),
                                          makeBackpackModule(),
                                          makeDetailModule(),
                                          makeCatchModule(),
                                          makeCommonModule(),
                                          makeNetworkModule()
                                         ])
func makeHanekeModule() -> Module {
    return Module(name: "Haneke",
                  path: "Haneke",
                  frameworkDependancies: [],
                  exampleDependencies: [],
                  frameworkResources: [],
                  exampleResources: ["Resources/**"],
    testResources: [])
}

func makeHomeModule() -> Module {
    return Module(name: "HomeUI",
                  path: "Home",
                  frameworkDependancies: [.target(name: "Common")],
                  exampleDependencies: [.package(product: "JGProgressHUD")],
                  frameworkResources: ["Sources/**/*.storyboard", "Resources/**"],
                  exampleResources: ["Resources/**"],
                  testResources: [])
}

func makeBackpackModule() -> Module {
    return Module(name: "BackpackUI",
           path: "Backpack",
           frameworkDependancies: [.target(name: "Common"), .target(name: "Haneke")],
           exampleDependencies: [.target(name: "Detail")],
           frameworkResources: ["Resources/**", "Sources/**/*.xib", "Sources/**/*.storyboard"],
           exampleResources: ["Resources/**", "Sources/**/*.storyboard"],
                  testResources: [])
}

func makeDetailModule() -> Module {
    return Module(name: "Detail",
                  path: "Detail",
                  frameworkDependancies: [.target(name: "Common"), .target(name: "Haneke")],
                  exampleDependencies: [],
                  frameworkResources: ["Sources/**/*.storyboard"],
                  exampleResources: ["Resources/**"],
                  testResources: [])
}

func makeCatchModule() -> Module {
    Module(name: "CatchUI",
           path: "Catch",
           frameworkDependancies: [.target(name: "Common"), .target(name: "Haneke")],
           exampleDependencies: [.package(product: "JGProgressHUD"), .target(name: "NetworkKit")],
           frameworkResources: ["Resources/**", "Sources/**/*.storyboard"],
           exampleResources: ["Resources/**", "Sources/**/*.storyboard"],
           testResources: [])
}

func makeCommonModule() -> Module {
    return Module(name: "Common",
                  path: "Common",
                  frameworkDependancies: [],
                  exampleDependencies: [],
                  frameworkResources: ["Sources/**/*.xib"],
                  exampleResources: ["Resources/**"],
                  testResources: [],
                  targets: [.framework, .unitTests])
}

func makeNetworkModule() -> Module {
    return Module(name: "NetworkKit",
                  path: "Network",
                  frameworkDependancies: [],
                  exampleDependencies: [.target(name: "Common")],
                  frameworkResources: ["Resources/**"],
                  exampleResources: ["Resources/**"],
                  testResources: ["**/*.json"])
}
