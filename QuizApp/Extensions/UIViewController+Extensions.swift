import UIKit
import MBProgressHUD

extension UIViewController {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func showProgress() {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.contentColor = .black
            hud.bezelView.style = .solidColor
            hud.backgroundColor = .systemBackground.withAlphaComponent(0.3)
        }
    }

    func hideProgress() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
