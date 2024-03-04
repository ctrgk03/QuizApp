struct GameState {
    let currentIndex: Int
    let questionCount: Int
    let totalScore: Int
    let isLastQuestion: Bool
}
protocol GameEngineProtocol {
    var gameState: GameState { get }
    func getQuestion() -> Question
    func handle(selectedAnswer: Answer)
}

final class GameEngine: GameEngineProtocol {
    private let questions: [Question]
    private var questionIndex: Int = 0
    private var totalScore: Int = 0

    var gameState: GameState {
        .init(
            currentIndex: questionIndex,
            questionCount: questions.count,
            totalScore: totalScore,
            isLastQuestion: questionIndex == (questions.count - 1)
        )
    }
    init(questions: [QuestionResponse]) {
        self.questions = questions.map { question in
            .init(
                questionText: question.question,
                imageURLString: question.questionImageURL,
                score: question.score,
                answers: question.answers.shuffled().map { [question] answerKey, answerText in
                    .init(text: answerText, isCorrect: question.correctAnswer == answerKey)
                }
            )
        }
    }

    func getQuestion() -> Question {
        questions[questionIndex]
    }

    func handle(selectedAnswer: Answer) {
        if selectedAnswer.isCorrect {
            totalScore += getQuestion().score
        }
    }

    func prepareForNextQuestion() {
        questionIndex += 1
    }
}
