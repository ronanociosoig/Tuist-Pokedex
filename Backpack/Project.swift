import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "Backpack",
                          platform: .iOS,
                          packages: [],
                          targetDependancies: [],
                          additionalTargets: [LocalFramework(name: "BackpackUI",
                                                             path: "Backpack",
                                                             frameworkDependancies: [.target(name: "PokedexCommon")],
                                                             resources: ["Targets/BackpackUI/Sources/**/*.xib",
                                                                         "Targets/BackpackUI/Sources/**/*.storyboard",
                                                                         "Targets/BackpackUI/Resources/**"]),
                                              LocalFramework(name: "Haneke",
                                                             path: "Haneke",
                                                             frameworkDependancies: [],
                                                             resources: []),
                                              LocalFramework(name: "PokedexCommon",
                                                            path: "Pokedex",
                                                            frameworkDependancies: [],
                                                            resources: [])
                          ])
