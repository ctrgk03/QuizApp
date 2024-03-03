import UIKit
import Reusable

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

    func configure(questionIdxText: String, totalScoreText: String) {
        questionIdxLabel.text = questionIdxText
        totalScoreLabel.text = totalScoreText
    }
}
