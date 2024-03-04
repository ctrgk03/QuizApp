import Foundation

protocol NetworkClientProtocol {
    var session: URLSession { get }
    func fetch<T: Decodable>(type: T.Type, with request: URLRequest) async throws -> T
}

enum NetworkError: Error {
    case requestFailed
    case decodingError
    case general
}

final class NetworkClient: NetworkClientProtocol {
    let session: URLSession = .shared

    func fetch<T: Decodable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.general
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
