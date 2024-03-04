import UIKit
import Reusable

final class AnswerCellModel {
    enum State {
        case notDetermined
        case correct
        case incorrect

        var cellBackgroundColor: UIColor {
            switch self {
                case .notDetermined: return .white
                case .correct: return .green
                case .incorrect: return .red
            }
        }
    }
    let answer: Answer
    var state: State

    init(answer: Answer, state: State = .notDetermined) {
        self.answer = answer
        self.state = state
    }
}

final class AnswerCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var answerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configure(_ model: AnswerCellModel) {
        answerLabel.text = model.answer.text
        contentView.backgroundColor = model.state.cellBackgroundColor
    }
 }
