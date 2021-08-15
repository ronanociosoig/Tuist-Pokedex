import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

func targets() -> [Target] {
    // var targets: [Target] = []
    
    let frameworkTargets = Project.makeFrameworkTargets(localFramework: LocalFramework(name: "Haneke",
                                                                             path: "Haneke",
                                                                             frameworkDependancies: [],
                                                                             resources: []), platform: .iOS)
    
    return frameworkTargets
}

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "Pokedex",
                          platform: .iOS,
                          packages: [
                            .package(url: "https://github.com/Moya/Moya.git", .exact("14.0.0")),
                            .package(url: "https://github.com/antitypical/Result.git", from: "5.0.0"),
                            .package(url: "https://github.com/JonasGessner/JGProgressHUD", .upToNextMajor(from: "2.0.0"))
                          ],
                          targetDependancies: [
                            .package(product: "JGProgressHUD")],
                          additionalTargets: [LocalFramework(name: "Haneke",
                                                             path: "Haneke",
                                                             frameworkDependancies: [],
                                                             resources: []),
                                              LocalFramework(name: "HomeUI",
                                                             path: "Home",
                                                             frameworkDependancies: [.target(name: "PokedexCommon")],
                                                             resources: ["Sources/**/*.storyboard",
                                                                         "Resources/**"]),
                                              LocalFramework(name: "BackpackUI",
                                                             path: "Backpack",
                                                             frameworkDependancies: [.target(name: "PokedexCommon")],
                                                             resources: ["Sources/**/*.xib",
                                                                         "Sources/**/*.storyboard"]),
                                              LocalFramework(name: "CatchUI",
                                                             path: "Catch",
                                                             frameworkDependancies: [.target(name: "PokedexCommon")],
                                                             resources: ["Sources/**/*.storyboard",
                                                                         "Resources/**"]),
                                              LocalFramework(name: "PokedexCommon",
                                                             path: "Pokedex",
                                                             frameworkDependancies: [],
                                                             resources: ["Sources/**/*.xib"]),
                                              LocalFramework(name: "NetworkKit",
                                                             path: "Network",
                                                             frameworkDependancies: [
                                                                .package(product: "Moya"),
                                                                .package(product: "Result")
                                                             ], resources: ["Resources/**"])
                          ])
