import UIKit
import NetworkKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let service = PokemonSearchService()
        let dataProvider = DataProvider(service: service)
        let viewController = SimpleViewController(dataProvider: dataProvider)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.view.backgroundColor = .white
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
