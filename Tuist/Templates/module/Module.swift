import ProjectDescription
import Foundation

let companyName = "Sonomos"
var defaultYear: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: Date())
}

var defaultDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter.string(from: Date())
}

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .required("author")
let yearAttribute: Template.Attribute = .optional("year", default: defaultYear)
let dateAttribute: Template.Attribute = .optional("date", default: defaultDate)
let companyAttribute: Template.Attribute = .optional("company", default: companyName)

let template = Template(
    description: "Module template",
    attributes: [
        nameAttribute,
        authorAttribute,
        yearAttribute,
        dateAttribute,
        companyAttribute,
        .optional("platform", default: "ios")
    ],
    files: [
        
        // Placeholder source file
        .file(
            path: "\(nameAttribute)/Sources/Scenes/\(nameAttribute)ViewController.swift",
            templatePath: "Scene.stencil"
        ),
        
        // Placeholder UnitTest
        .file(
            path: "\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
            templatePath: "Tests.stencil"
        ),
        
        // Example App Icons and Launch Screen
        .directory(
            path: "\(nameAttribute)/Example",
            sourcePath: "Resources"
        ),
        .file(
            path: "\(nameAttribute)/Example/Resources/LaunchScreen.storyboard",
            templatePath: "LaunchScreen.stencil"
        ),
        .file(
            path: "\(nameAttribute)/Example/Sources/AppController.swift",
            templatePath: "ExampleAppController.stencil"
        ),
        .file(
            path: "\(nameAttribute)/Example/Sources/AppDelegate.swift",
            templatePath: "ExampleAppDelegate.stencil"
        ),
        .file(
            path: "\(nameAttribute)/Example/Sources/Coordinator.swift",
            templatePath: "ExampleCoordinator.stencil"
        )
    ]
)
