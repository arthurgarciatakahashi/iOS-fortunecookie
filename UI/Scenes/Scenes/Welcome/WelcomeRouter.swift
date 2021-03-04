import Foundation

public final class WelcomeRouter {
    private let nav: NavigationController
    private let loginFactory: () -> LoginViewController
    private let signUpFactory: () -> SignUpViewController
    private let fortuneFactory: () -> FortuneViewController

    
    public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController, signUpFactory: @escaping () -> SignUpViewController, fortuneFactory: @escaping () -> FortuneViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
        self.fortuneFactory = fortuneFactory
    }
    
    public func goToFortune() {
        nav.pushViewController(fortuneFactory())
    }
    
    public func goToLogin() {
        nav.pushViewController(loginFactory())
    }
    
    public func goToSignUp() {
        nav.pushViewController(signUpFactory())
    }
}
