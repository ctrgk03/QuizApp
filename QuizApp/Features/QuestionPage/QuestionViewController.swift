import UIKit
import Reusable

protocol QuestionViewControllerDelegate: AnyObject {
    func questionAnswered()
}

protocol QuestionDisplayLogic: AnyObject {
    func displayQuestion(_ viewModel: QuestionPage.PrepareQuestion.ViewModel)
    func disaplayAnsweredQuestion(_ viewModel: QuestionPage.AnswerQuestion.ViewModel)
}

final class QuestionViewController: UIViewController, Reusable {
    @IBOutlet private weak var tableView: UITableView!
    var interactor: QuestionBusinessLogic?
    var router: (NSObjectProtocol & QuestionRoutingLogic & QuestionDataPassing)?
    weak var delegate: QuestionViewControllerDelegate?

    private var headerModel: QuestionHeaderViewModel?
    private var answers: [AnswerCellModel] = []

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
        interactor?.prepareQuestion()
    }

    private func setupTableView() {
        tableView.register(cellType: AnswerCell.self)
    }

    private func setupNavigation(_ model: NavBarTitleViewModel) {
        let titleView = NavBarTitleView()
        titleView.configure(model)
        navigationItem.titleView = titleView
    }

    private func routeToNextQuestion() {
        tableView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegate?.questionAnswered()
        }
    }
}

extension QuestionViewController: QuestionDisplayLogic {
    func disaplayAnsweredQuestion(_ viewModel: QuestionPage.AnswerQuestion.ViewModel) {
        setupNavigation(viewModel.navigationBarTitleModel)
        answers = viewModel.answers
        let rowsToReload = (0..<answers.count).map { IndexPath(row: $0, section: 0) }
        tableView.reloadRows(at: rowsToReload, with: .automatic)
        routeToNextQuestion()
    }

    func displayQuestion(_ viewModel: QuestionPage.PrepareQuestion.ViewModel) {
        setupNavigation(viewModel.navigationBarTitleModel)
        headerModel = viewModel.headerModel
        answers = viewModel.answers
        tableView.reloadData()
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AnswerCell.self)
        let model = answers[indexPath.row]
        cell.configure(model)
        return cell
    }
}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answer = answers[indexPath.row]
        interactor?.answerQuestion(answer: answer.answer)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerModel else { return nil }
        let header = QuestionHeaderView()
        header.configure(headerModel)
        return header
    }
}
