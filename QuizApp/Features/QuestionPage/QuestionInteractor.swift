import UIKit

protocol QuestionBusinessLogic {
    // func doSomething(request: Question.Something.Request)
}

protocol QuestionDataStore {
    //var name: String { get set }
}

final class QuestionInteractor: QuestionBusinessLogic, QuestionDataStore {
    var presenter: QuestionPresentationLogic?

}
