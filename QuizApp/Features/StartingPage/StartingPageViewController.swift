import UIKit

protocol StartingPageDisplayLogic: AnyObject {}

final class StartingPageViewController: UIViewController, StartingPageDisplayLogic {
    var interactor: StartingPageBusinessLogic?
    var router: (StartingPageRoutingLogic & StartingPageDataPassing)?

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
    }

    @IBAction func tappedStartButton(_ sender: Any) {
        router?.startQuiz()
    }
}
