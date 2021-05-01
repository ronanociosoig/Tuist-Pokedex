import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let project = Project.app(name: "Network",
                          platform: .iOS,
                          additionalTargets: ["NetworkKit"])
