import UIKit

protocol QuestionRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol QuestionDataPassing: NSObject {
    var dataStore: QuestionDataStore? { get }
}

final class QuestionRouter: NSObject, QuestionRoutingLogic, QuestionDataPassing {
    weak var viewController: QuestionViewController?
    var dataStore: QuestionDataStore?
}
