import UIKit
import Reusable
import Kingfisher

struct QuestionHeaderViewModel {
    let scoreOfQuestionText: String
    let questionImageURL: URL?
    let questionText: String
}

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
    }

    func configure(_ model: QuestionHeaderViewModel) {
        scoreOfQuestionLabel.text = model.scoreOfQuestionText
        questionLabel.text = model.questionText
        guard let url = model.questionImageURL else {
            imageView.isHidden = true
            return
        }
        print(url)
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo")
        )
    }
}
