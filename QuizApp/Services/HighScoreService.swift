import Foundation

protocol HighScoreService {
    func getHighScore() -> Int
    func saveHightScore(_ score: Int)
}

struct LocalHighScoreService: HighScoreService {
    enum StorageKeys: String { case highScore }
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func getHighScore() -> Int {
        userDefaults.integer(forKey: StorageKeys.highScore.rawValue )
    }

    func saveHightScore(_ score: Int) {
        userDefaults.set(score, forKey: StorageKeys.highScore.rawValue )
    }
}
