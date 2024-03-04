struct Question {
    let questionText: String
    let imageURLString: String?
    let score: Int
    let answers: [Answer]

    init(questionText: String, imageURLString: String?, score: Int, answers: [Answer]) {
        self.questionText = questionText
        self.imageURLString = imageURLString
        self.score = score
        self.answers = answers
    }
}

struct Answer {
    let text: String
    let isCorrect: Bool
}
