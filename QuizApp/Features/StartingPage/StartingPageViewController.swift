import UIKit

protocol StartingPageViewControllerDelegate: AnyObject {
    func startButtonTapped()
}

protocol StartingPageDisplayLogic: AnyObject {
    func displayHighScore(_ viewModel: StartingPage.PrepareHighScore.ViewModel)
}

final class StartingPageViewController: UIViewController, StartingPageDisplayLogic {
    @IBOutlet private weak var highScoreLabel: UILabel!
    var interactor: StartingPageBusinessLogic?
    var router: (StartingPageRoutingLogic & StartingPageDataPassing)?
    weak var delegate: StartingPageViewControllerDelegate?

    init() {
        super.init(nibName: "StartingPageViewController", bundle: .main)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = StartingPageInteractor()
        let presenter = StartingPagePresenter()
        let router = StartingPageRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quiz App"
        interactor?.prepareHighScore()
    }

    @IBAction func tappedStartButton(_ sender: Any) {
        delegate?.startButtonTapped()
    }

    func displayHighScore(_ viewModel: StartingPage.PrepareHighScore.ViewModel) {
        highScoreLabel.text = viewModel.highScoreText
    }
}
