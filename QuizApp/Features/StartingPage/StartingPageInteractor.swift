protocol StartingPageBusinessLogic {
}

protocol StartingPageDataStore {
}

final class StartingPageInteractor: StartingPageBusinessLogic, StartingPageDataStore {
    var presenter: StartingPagePresentationLogic?
}
