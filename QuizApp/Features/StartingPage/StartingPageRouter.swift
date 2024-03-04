import UIKit

protocol StartingPageRoutingLogic {
}

protocol StartingPageDataPassing: AnyObject {
    var dataStore: StartingPageDataStore? { get }
}

final class StartingPageRouter: NSObject, StartingPageRoutingLogic, StartingPageDataPassing {
    weak var viewController: StartingPageViewController?
    var dataStore: StartingPageDataStore?
}
