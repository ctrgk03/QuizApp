import UIKit
import Factory

protocol QuestionPresentationLogic {
    func presentQuestion(question: Question, gameState: GameState)
    func presentAnsweredQuestion(question: Question, gameState: GameState, selectedAnswer: Answer)
}

final class QuestionPresenter: QuestionPresentationLogic {
    weak var viewController: QuestionDisplayLogic?

    func presentQuestion(question: Question, gameState: GameState) {
        let headerModel = QuestionHeaderViewModel(
            scoreOfQuestionText: "\(question.score) puan",
            questionImageURL: URL(string: question.imageURLString ?? ""),
            questionText: question.questionText
        )

        let viewModel = QuestionPage.PrepareQuestion.ViewModel(
            navigationBarTitleModel: navBarTitleViewModel(gameState),
            headerModel: headerModel,
            answers: initialCellModels(question)
        )
        viewController?.displayQuestion(viewModel)
    }

    private func initialCellModels(_ question: Question) -> [AnswerCellModel] {
        question.answers.map { answer in
            AnswerCellModel(
                answer: answer,
                state: .notDetermined
            )
        }
    }

    func presentAnsweredQuestion(question: Question, gameState: GameState, selectedAnswer: Answer) {
        let viewModel = QuestionPage.AnswerQuestion.ViewModel(
            navigationBarTitleModel: navBarTitleViewModel(gameState),
            answers: cellModelsAfterAnswer(question, selectedAnswer: selectedAnswer)
        )
        viewController?.disaplayAnsweredQuestion(viewModel)
    }

    private func cellModelsAfterAnswer(_ question: Question, selectedAnswer: Answer) -> [AnswerCellModel] {
        question.answers.map { answer in
            let model = AnswerCellModel(answer: answer)
            let isAnsweredByUser = answer.text == selectedAnswer.text
            let isCorrectAnswer = answer.isCorrect
            guard isAnsweredByUser else {
                model.state = isCorrectAnswer ? .correct : .notDetermined
                return model
            }

            model.state = isCorrectAnswer ? .correct : .incorrect
            return model
        }
    }

    private func navBarTitleViewModel(_ gameInfo: GameState) -> NavBarTitleViewModel {
        NavBarTitleViewModel(
            questionIndexText: "Soru \(gameInfo.currentIndex + 1)/\(gameInfo.questionCount)",
            totalScoreText: "Total Puanınız: \(gameInfo.totalScore)"
        )
    }
}
