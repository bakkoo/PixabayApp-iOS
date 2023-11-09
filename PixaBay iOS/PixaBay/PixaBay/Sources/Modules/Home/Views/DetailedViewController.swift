import UIKit
import Networking

class DetailedPageTableViewController: UITableViewController {
    var coordinator: HomeCoordinatorProtocol?
    var viewModel: HomeViewModel!
    var hit: Hit?
    
    private var imageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupImage()
    }
    
    private func setupImage() {
        imageView?.downloaded(from: hit?.previewURL ?? "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 6
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.imageView?.image = imageView?.image
            case 1:
                cell.textLabel?.text = "Photo Size: \(String(describing: hit?.imageSize))"
            case 2:
                cell.textLabel?.text = "Photo Type: \(String(describing: hit?.type))"
            case 3:
                cell.textLabel?.text = "Photo Tags: \(String(describing: hit?.tags))"
            default:
                break
            }
        } else {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Photographer Information: \(String(describing: hit?.user))"
            case 1:
                cell.textLabel?.text = "Number of Views: \(String(describing: hit?.views))"
            case 2:
                cell.textLabel?.text = "Number of Likes: \(String(describing: hit?.likes))"
            case 3:
                cell.textLabel?.text = "Number of Comments: \(String(describing: hit?.comments))"
            case 4:
                cell.textLabel?.text = "Number of Favorites: \(String(describing: hit?.likes))"
            case 5:
                cell.textLabel?.text = "Number of Downloads: \(String(describing: hit?.downloads))"
            default:
                break
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Section 1" : "Section 2"
    }
}
