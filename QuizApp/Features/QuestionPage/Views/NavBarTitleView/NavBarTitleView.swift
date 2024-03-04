import UIKit
import Reusable

struct NavBarTitleViewModel {
    let questionIndexText: String
    let totalScoreText: String
}
final class NavBarTitleView: UIView, NibOwnerLoadable {

    @IBOutlet private weak var questionIdxLabel: UILabel!
    @IBOutlet private weak var totalScoreLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        loadNibContent()
    }

    func configure(_ model: NavBarTitleViewModel) {
        questionIdxLabel.text = model.questionIndexText
        totalScoreLabel.text = model.totalScoreText
    }
}
