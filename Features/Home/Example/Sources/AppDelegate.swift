import UIKit
import HomeUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appController = AppController()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        appController.start()
        
        return true
    }
}
