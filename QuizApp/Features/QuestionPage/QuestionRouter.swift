import UIKit

protocol QuestionRoutingLogic {
}

protocol QuestionDataPassing: NSObject {
    var dataStore: QuestionDataStore? { get set }
}

final class QuestionRouter: NSObject, QuestionRoutingLogic, QuestionDataPassing {
    weak var viewController: QuestionViewController?
    var dataStore: QuestionDataStore?
}
