struct QuestionsResponse: Decodable {
    let questions: [QuestionResponse]
}

struct QuestionResponse: Codable {
    let question: String
    let answers: [String: String]
    let questionImageURL: String?
    let correctAnswer: String
    let score: Int

    enum CodingKeys: String, CodingKey {
        case question, answers
        case questionImageURL = "questionImageUrl"
        case correctAnswer, score
    }
}
