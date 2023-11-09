import UIKit
import Networking
import Combine

class HomeViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    weak var coordinator: HomeCoordinatorProtocol?
    var imageRepository: ImageRepositoryProtocol!
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureViewModel()
        getHits()
    }
    
    private func configureViewModel() {
        imageRepository = ImageRepository(apiClient: DefaultAPIClient())
        viewModel = HomeViewModel(imageRepository: imageRepository, homeCoordinator: coordinator)
    }

    private func setupUI() {
        view.backgroundColor = .white
        collectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: "ImagesCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func getHits() {
        viewModel.getHits {[weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as? ImagesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.datasource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let cellHeight: CGFloat = 200
        let cellWidth = (collectionView.frame.width - 3 * padding) / 2
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard viewModel.isPaginationAllowed() else { return }
            
            viewModel.isPaginationInProgress = true
            viewModel.getHits { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}
