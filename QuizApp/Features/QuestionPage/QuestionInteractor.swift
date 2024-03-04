import Factory

protocol QuestionBusinessLogic {
    func prepareQuestion()
    func answerQuestion(answer: Answer)
}

protocol QuestionDataStore {
}

final class QuestionInteractor: QuestionBusinessLogic, QuestionDataStore {
    private let gameEngine: GameEngineProtocol! = Container.shared.gameEngine()
    var presenter: QuestionPresentationLogic?

    func prepareQuestion() {
        presenter?.presentQuestion(
            question: gameEngine.getQuestion(),
            gameState: gameEngine.gameState
        )
    }

    func answerQuestion(answer: Answer) {
        gameEngine.handle(selectedAnswer: answer)
        presenter?.presentAnsweredQuestion(
            question: gameEngine.getQuestion(),
            gameState: gameEngine.gameState,
            selectedAnswer: answer
        )
    }
}
