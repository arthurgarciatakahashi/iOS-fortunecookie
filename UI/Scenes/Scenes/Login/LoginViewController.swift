import Foundation
import UIKit
import Presentation
import Domain

public final class LoginViewController: UIViewController, Storyboarded {
    public var login: ((SignUpViewModel) -> Void)?

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signIn: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Login"
        hideKeyboardOnTap()
    }
}
   
extension LoginViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator?.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator?.stopAnimating()
        }
    }
}

extension LoginViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        
        present(alert, animated: true)
    }
}
