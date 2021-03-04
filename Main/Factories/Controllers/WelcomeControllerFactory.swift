import Foundation
import UI

public func makeWelcomeController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginController, signUpFactory: makeSignUpController, fortuneFactory: makeFortuneController)
    let controller = WelcomeViewController.instanciate()
    controller.signUp = router.goToSignUp
    controller.login = router.goToLogin
    controller.fortune = router.goToFortune
    return controller
}
