import UIKit
import Reusable
import Kingfisher

final class QuestionHeaderView: UIView, NibOwnerLoadable {

    @IBOutlet private weak var scoreOfQuestionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        loadNibContent()
        imageView.kf.setImage(
            with: URL(string: ""),
            placeholder: UIImage(systemName: "photo")
        )
    }
}
