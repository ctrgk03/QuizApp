protocol StartingPagePresentationLogic {
    func presentHighScore(_ score: Int)
}

final class StartingPagePresenter: StartingPagePresentationLogic {
    weak var viewController: StartingPageDisplayLogic?

    func presentHighScore(_ score: Int) {
        viewController?.displayHighScore(.init(highScoreText: "Highscore: \n \(score) points"))
    }
}
