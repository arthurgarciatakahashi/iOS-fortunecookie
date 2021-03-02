import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeLoginController() -> LoginViewController {
    makeLoginControllerWith(authentication: makeRemoteAuthentication())
}
//public func makeLoginController() -> LoginViewController {
//    makeLoginControllerWith(nav: NavigationController())
//}
//public func makeLoginControllerWith(nav: NavigationController) -> LoginViewController {
//    let router = LoginRouter(nav: nav, fortuneFactory: makeFortuneController)
//    let controller = LoginViewController.instanciate()
//    let validationComposite = ValidationComposite(validations: makeLoginValidations())
//    let presenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: makeRemoteAuthentication(), validation: validationComposite, loadingView: WeakVarProxy(controller))
//    
//    controller.fortune = router.goToFortune
//    controller.login = presenter.login
//    
//    return controller
//}


public func makeLoginControllerWith(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController.instanciate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: authentication, validation: validationComposite, loadingView: WeakVarProxy(controller))
    
    controller.login = presenter.login
    
    return controller
}


public func makeLoginValidations() -> [Validation] {
    return ValidationBuilder.field("email").label("Email").required().email().build() +
        ValidationBuilder.field("password").label("Password").required().build()
}
