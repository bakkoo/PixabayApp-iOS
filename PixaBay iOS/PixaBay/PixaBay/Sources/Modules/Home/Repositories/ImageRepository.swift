import Foundation
import Networking
import Combine
import UIKit

protocol ImageRepositoryProtocol: AnyObject {
    func getImages(pageNumber: Int, perPageNumber: Int, completion: @escaping (Result<[Hit], NetworkError>) -> Void)
}


class ImageRepository: ImageRepositoryProtocol {
    private var apiClient: APIClient
    private var subscriptions = Set<AnyCancellable>()
    private var baseUrl: String = "https://pixabay.com/api/?key=19166111-a9c37db94625d414e9c2be9c3&q&image_type=photo"
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getImages(pageNumber: Int, perPageNumber: Int, completion: @escaping (Result<[Hit], NetworkError>) -> Void) {
        let url = "\(baseUrl)&page=\(pageNumber)&per_page=\(perPageNumber)"
        
        apiClient.getData(endpoint: url, type: ImageModel.self)
            .sink { [weak self] future in
                switch future {
                case .failure(let error):
                    print("🔴 Error at \(String(describing: self)) - \(String(describing: error.localizedDescription))")
                    completion(.failure(.invalidURL))
                case .finished:
                    print("🟢 Data Fetched Successfully")
                }
            } receiveValue: { [weak self] imageModel in
                completion(.success(imageModel.hits))
            }
            .store(in: &subscriptions)
    }

    
}

