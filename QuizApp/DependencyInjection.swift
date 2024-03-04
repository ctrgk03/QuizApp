import Factory

extension Container {
    var gameEngine: Factory<GameEngineProtocol?> {
        self { nil }
    }

    var highScoreService: Factory<HighScoreService> {
        self { LocalHighScoreService() }.scope(.singleton)
    }

    var networkClient: Factory<NetworkClientProtocol> {
        self { NetworkClient() }.scope(.singleton)
    }

    var quizAppService: Factory<QuizAppService> {
        self { MockQuizAppService() }.scope(.singleton)
    }
}
