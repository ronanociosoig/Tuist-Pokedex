import ProjectDescription

let dependencies = Dependencies(
    carthage: [
        .github(path: "JonasGessner/JGProgressHUD", requirement: .upToNext("2.0.0")),
    ],
    platforms: [.iOS]
)

