import Factory

protocol StartingPageBusinessLogic {
    func prepareHighScore()
}

protocol StartingPageDataStore {
}

final class StartingPageInteractor: StartingPageBusinessLogic, StartingPageDataStore {
    private let highScoreService = Container.shared.highScoreService()
    var presenter: StartingPagePresentationLogic?


    func prepareHighScore() {
        presenter?.presentHighScore(highScoreService.getHighScore())
    }
}
