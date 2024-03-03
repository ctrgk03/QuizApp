import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let flowController = GameFlowController()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        AppDelegate.flowController.start(window)
        return true
    }
}
