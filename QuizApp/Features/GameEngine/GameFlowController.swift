import UIKit

final class GameFlowController {

    private let navigationController: UINavigationController
    private var engine: GameEngine!
    private let service: QuizAppService

    init(
        service: QuizAppService = MockQuizAppService(),
        navigationController: UINavigationController
    ) {
        self.service = service
        self.navigationController = navigationController
    }

    func start() {
        let controller = StartingPageViewController()
        navigationController.setViewControllers([controller], animated: false)
    }

    func startQuiz() {
        navigationController.showProgress()
        service.fetchQuestions { [weak self] result in
            self?.navigationController.hideProgress()
            switch result {
                case .success(let questionsResponse):
                    self?.engine = .init(questions: questionsResponse.questions)
                    self?.routeToNextQuestionPage()
                case .failure(let error):
                    self?.navigationController.showAlert(
                        title: "Hata",
                        message: error.message
                    )
            }
        }
    }

    private func routeToNextQuestionPage() {
        let questionViewController = QuestionViewController()
        navigationController.setViewControllers([questionViewController], animated: true)
    }
}
