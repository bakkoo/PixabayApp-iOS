import Foundation
import UIKit
import Combine
import Networking

class HomeViewModel {
    
    // MARK: - Properties
    
    var datasource = [ImageCellData]()
    private var hits = [Hit]()
    
    private var subscriptions = Set<AnyCancellable>()
    private let imageRepository: ImageRepositoryProtocol
    private let coordinator: HomeCoordinatorProtocol?
    
    var pageNumber = 1
    private var perPageNumber = 10
    
    var isPaginationInProgress: Bool = false
    var isReachedMaxPageIndex: Bool = false
    
    // MARK: - Initialization
    
    init(imageRepository: ImageRepositoryProtocol, homeCoordinator: HomeCoordinatorProtocol?) {
        self.imageRepository = imageRepository
        self.coordinator = homeCoordinator
    }
    
    // MARK: - Fetching Hits
    
    func getHits(completion: @escaping (Result<Void, HitError>) -> ()) {
        if isPaginationInProgress {
            pageNumber += 1
        }
        
        imageRepository.getImages(pageNumber: pageNumber, perPageNumber: perPageNumber) { [weak self] result in
            switch result {
            case .success(let hits):
                self?.hits.append(contentsOf: hits)
                hits.forEach { hit in
                    self?.datasource.append(.init(imageUrl: hit.previewURL, title: hit.user, subtitle: hit.previewURL, id: hit.id))
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.errorFetchingData))
                break
            }
        }
        stopPagination()
    }
    
    // MARK: - Row Selection
    
    func didSelectRow(at indexPath: IndexPath) {
        let selectedDatasource = datasource[indexPath.row]
        guard let selectedHit = hits.filter({ $0.id == selectedDatasource.id }).first else { return }
        coordinator?.showDetailedPage(with: selectedHit)
    }

    // MARK: - Pagination
    
    func isPaginationAllowed() -> Bool {
        !isPaginationInProgress
    }
    
    func stopPagination() {
        isPaginationInProgress = false
    }
    
}
