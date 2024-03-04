import UIKit

enum QuestionPage {
    enum PrepareQuestion {
        struct ViewModel {
            let navigationBarTitleModel: NavBarTitleViewModel
            let headerModel: QuestionHeaderViewModel
            let answers: [AnswerCellModel]
        }
    }

    enum AnswerQuestion {
        struct ViewModel {
            let navigationBarTitleModel: NavBarTitleViewModel
            let answers: [AnswerCellModel]
        }
    }
}
