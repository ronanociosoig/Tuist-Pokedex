import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

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
                          moduleTargets: [Module(name: "Haneke",
                                                             path: "Haneke",
                                                             frameworkDependancies: [],
                                                             exampleDependencies: [],
                                                             resources: []),
                                              Module(name: "HomeUI",
                                                             path: "Home",
                                                             frameworkDependancies: [.target(name: "PokedexCommon")],
                                                             exampleDependencies: [.package(product: "JGProgressHUD")],
                                                             resources: ["Sources/**/*.storyboard",
                                                                         "Resources/**"]),
                                              Module(name: "BackpackUI",
                                                             path: "Backpack",
                                                             frameworkDependancies: [.target(name: "PokedexCommon"),
                                                                                     .target(name: "Haneke")],
                                                             exampleDependencies: [],
                                                             resources: ["Sources/**/*.xib",
                                                                         "Sources/**/*.storyboard"]),
                                              Module(name: "CatchUI",
                                                             path: "Catch",
                                                             frameworkDependancies: [.target(name: "PokedexCommon"),
                                                                                     .target(name: "Haneke")],
                                                             exampleDependencies: [.package(product: "JGProgressHUD"),
                                                                                   .target(name: "NetworkKit")],
                                                             resources: ["Sources/**/*.storyboard",
                                                                         "Resources/**"]),
                                              Module(name: "PokedexCommon",
                                                             path: "PokedexCommon",
                                                             frameworkDependancies: [],
                                                             exampleDependencies: [],
                                                             resources: ["Sources/**/*.xib"]),
                                              Module(name: "NetworkKit",
                                                             path: "Network",
                                                             frameworkDependancies: [
                                                                .package(product: "Moya"),
                                                                .package(product: "Result")
                                                             ],
                                                             exampleDependencies: [.target(name: "PokedexCommon")],
                                                             resources: ["Resources/**"])
                          ])
