import UIKit
import Reusable

protocol QuestionDisplayLogic: AnyObject {
    //func display(viewModel: Question.Something.ViewModel)
}

final class QuestionViewController: UIViewController, QuestionDisplayLogic, Reusable {
    @IBOutlet private weak var tableView: UITableView!
    var interactor: QuestionBusinessLogic?
    var router: (NSObjectProtocol & QuestionRoutingLogic & QuestionDataPassing)?

    init() {
        super.init(nibName: QuestionViewController.reuseIdentifier, bundle: .main)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = QuestionInteractor()
        let presenter = QuestionPresenter()
        let router = QuestionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
    }

    func displaySomething(viewModel: QuestionPage.PrepareQuestion.ViewModel) {
        //nameTextField.text = viewModel.name
    }

    // prepare navigation veya prepare Data sonunda dönen viewmodel'ın ardından çağırılabilir
    private func setupNavigation() {
        navigationItem.titleView = NavBarTitleView()
    }

    private func setupTableView() {
        tableView.register(cellType: AnswerCell.self)
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(for: indexPath, cellType: AnswerCell.self)
    }
}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        QuestionHeaderView()
    }
}
