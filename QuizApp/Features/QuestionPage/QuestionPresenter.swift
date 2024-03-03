import UIKit

protocol QuestionPresentationLogic {
    // func presentSomething(response: QuestionPage.Something.Response)
}

final class QuestionPresenter: QuestionPresentationLogic {
    weak var viewController: QuestionDisplayLogic?

//    func presentSomething(response: Question.Something.Response) {
//        let viewModel = Question.Something.ViewModel()
//        viewController?.displaySomething(viewModel: viewModel)
//    }
}
