import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "Pokedex",
                          packages: [.package(url: "https://github.com/JonasGessner/JGProgressHUD", .upToNextMajor(from: "2.0.0")),
                                     .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
                                     .package(url: "https://github.com/antitypical/Result.git", from: "5.0.0")],
                          platform: .iOS,
                          additionalTargets: [])
