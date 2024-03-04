import UIKit
import Factory

final class GameFlowController {
    private let highScoreService = Container.shared.highScoreService()
    private let quizAppService = Container.shared.quizAppService()
    private let navigationController: UINavigationController
    private var engine: GameEngine!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func routeToStartingPage() {
        let controller = StartingPageViewController()
        controller.delegate = self
        navigationController.setViewControllers([controller], animated: false)
    }

    func startQuiz() {
        navigationController.showProgress()
        quizAppService.fetchQuestions { [weak self] result in
            self?.navigationController.hideProgress()
            switch result {
                case .success(let questionsResponse):
                    self?.handleSuccessfulResponse(questionsResponse)
                case .failure(let error):
                    self?.navigationController.showAlert(
                        title: "Hata",
                        message: error.message
                    )
            }
        }
    }

    private func handleSuccessfulResponse(_ response: QuestionsResponse) {
        engine = .init(questions: response.questions)
        Container.shared.gameEngine.register { self.engine }.scope(.singleton)
        routeToNextQuestionPage()
    }

    private func routeToNextQuestionPage() {
        let questionViewController = QuestionViewController()
        questionViewController.delegate = self
        navigationController.setViewControllers([questionViewController], animated: true)
    }

    private func endGame() {
        highScoreService.saveHightScore(engine.gameState.totalScore)
        navigationController.showEndGameAlert { [weak self] in
            self?.routeToStartingPage()
        }
    }
}
extension GameFlowController: StartingPageViewControllerDelegate {
    func startButtonTapped() {
        startQuiz()
    }
}

extension GameFlowController: QuestionViewControllerDelegate {
    func questionAnswered() {
        guard !engine.gameState.isLastQuestion else {
            endGame()
            return
        }
        engine.prepareForNextQuestion()
        routeToNextQuestionPage()
    }
}
