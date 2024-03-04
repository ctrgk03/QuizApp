import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var flowController: GameFlowController!
    private let navigationController = UINavigationController()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        configureNavigationBarAppearance()
        startFlowController()
        return true
    }

    private func configureNavigationBarAppearance() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        let navBar = navigationController.navigationBar
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navBar.compactAppearance = standardAppearance
    }

    private func startFlowController() {
        flowController = .init(navigationController: navigationController)
        flowController.routeToStartingPage()
    }
}
