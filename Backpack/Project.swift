import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "Backpack",
                          platform: .iOS,
                          packages: [],
                          targetDependancies: [],
                          additionalTargets: [LocalFramework(name: "BackpackUI", path: "Backpack", frameworkDependancies: []),
                                              LocalFramework(name: "Haneke", path: "Haneke", frameworkDependancies: [])
                          ])
