import Foundation
import Factory

private let unexpectedErrorMessage = "Beklenmeyen bir hata meydana geldi!"
typealias QuizAppServiceResult = Result<QuestionsResponse, QuizAppServiceError>
typealias QuizAppServiceCompletion = (QuizAppServiceResult) -> Void

struct QuizAppServiceError: Error {
    let message: String
}

protocol QuizAppService {
    func fetchQuestions(completion: @escaping QuizAppServiceCompletion)
}

struct MockQuizAppService: QuizAppService {
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
        .failure(QuizAppServiceError(message: unexpectedErrorMessage))
    }
}

struct RemoteQuizAppService: QuizAppService {
    private let networkClient = Container.shared.networkClient()

    func fetchQuestions(completion: @escaping QuizAppServiceCompletion) {
        Task { @MainActor in
            let url = URL(string: "http://demo3633203.mockable.io/hbquiz")!
            do {
                let response = try await networkClient.fetch(type: QuestionsResponse.self, with: URLRequest(url: url))
                completion(.success(response))
            } catch {
                completion(.failure(.init(message: unexpectedErrorMessage)))
            }
        }
    }
}
