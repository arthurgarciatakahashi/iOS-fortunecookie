import Foundation
import UIKit
import Presentation
import Domain

public final class WelcomeViewController: UIViewController, Storyboarded {
    public var login: (() -> Void)?
    public var signUp: (() -> Void)?

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "Welcome"
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signInButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        login?()
    }
    
    @objc private func signUpButtonTapped() {
        signUp?()
    }
}
