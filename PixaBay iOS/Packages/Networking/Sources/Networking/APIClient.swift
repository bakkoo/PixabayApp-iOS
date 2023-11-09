import Foundation
import Combine

public protocol APIClient {
    func getData<T: Decodable>(endpoint: String, type: T.Type) -> AnyPublisher<T, Error>
}

public class DefaultAPIClient: APIClient {
    public init() { }
    
    private var subscriptions = Set<AnyCancellable>()
    
    public func getData<T: Decodable>(endpoint: String, type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        print("URL is \(url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.current)
            .eraseToAnyPublisher()
    }
}



protocol CombineAPI {
    var session: URLSession { get }
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue) -> AnyPublisher<T, Error> where T: Decodable
}

extension CombineAPI {
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type,
                    queue: DispatchQueue = .main) -> AnyPublisher<T, Error> where T: Decodable {
        
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.invalidURL
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
