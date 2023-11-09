import Foundation
import UIKit

private var loadingView: UIView?

extension UIViewController {
    
    static func instantiate() -> Self { .init() }
    
    func showAlert(title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoader() {
        loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        loadingView?.center = view.center
        loadingView?.layer.cornerRadius = 10
        loadingView?.backgroundColor = UIColor(named: "AccentColor")
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: loadingView!.bounds.width / 2, y: loadingView!.bounds.height / 2)
        activityIndicator.startAnimating()
        
        loadingView?.addSubview(activityIndicator)
        view.addSubview(loadingView!)
    }
    
    func hideLoader() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
}
