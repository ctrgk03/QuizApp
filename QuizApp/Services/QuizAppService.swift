import Foundation

typealias QuizAppServiceResult = Result<QuestionsResponse, QuizAppServiceError>
typealias QuizAppServiceCompletion = (QuizAppServiceResult) -> Void

struct QuizAppServiceError: Error {
    let message: String
}

protocol QuizAppService {
    func fetchQuestions(completion: @escaping QuizAppServiceCompletion)
}

final class MockQuizAppService: QuizAppService {
    func fetchQuestions(completion: @escaping QuizAppServiceCompletion) {
        completion(successResult())
    }

    private func successResult() -> QuizAppServiceResult {
        let url: URL! = Bundle.main.url(
            forResource: "data",
            withExtension: ".json"
        )
        let data = try! Data(contentsOf: url)
        let response = try! JSONDecoder().decode(QuestionsResponse.self, from: data)
        return .success(response)
    }

    private func failingResult() -> QuizAppServiceResult {
        .failure(QuizAppServiceError(message: "Beklenmeyen bir hata meydana geldi!"))
    }
}

final class RemoteQuizAppService: QuizAppService {
    // private let network

    func fetchQuestions(completion: @escaping QuizAppServiceCompletion) {

    }
}
