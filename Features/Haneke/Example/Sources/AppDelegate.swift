import UIKit
import Haneke

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = makeViewController()
        addImageView(to: viewController.view)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
    
    func makeViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        return viewController
    }
    
    func addImageView(to view: UIView) {
        let imagePath = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/196.png"
        let diameter: CGFloat = 128
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: diameter),
            imageView.heightAnchor.constraint(equalToConstant: diameter)
        ])
        
        if let imageURL = URL(string: imagePath) {
            imageView.hnk_setImage(from: imageURL)
        }
    }
}
