import UIKit

final class GameFlowController {

    private var navigationController: UINavigationController!
    private var engine: GameEngine!
    private let service: QuizAppService

    init(service: QuizAppService = MockQuizAppService()) {
        self.service = service
    }

    func start(_ window: UIWindow?) {
        routeToStartingPage(window)
    }

    func startQuiz() {
        navigationController.showProgress()
        service.fetchQuestions { [weak self] result in
            self?.navigationController.hideProgress()
            switch result {
                case .success(let questionsResponse):
                    self?.engine = .init(questions: questionsResponse.questions)
                case .failure(let error):
                    self?.navigationController.showAlert(
                        title: "Hata",
                        message: error.message
                    )
            }
        }
    }

    private func routeToStartingPage(_ window: UIWindow?) {
        let controller = StartingPageViewController()
        navigationController = .init(rootViewController: controller)
        window?.rootViewController = navigationController
    }
}
