import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(name: "Network",
                          platform: .iOS,
                          packages: [
                            .package(url: "https://github.com/Moya/Moya.git", .exact("14.0.0")),
                            .package(url: "https://github.com/antitypical/Result.git", from: "5.0.0")
                          ],
                          additionalTargets: ["NetworkKit"])
