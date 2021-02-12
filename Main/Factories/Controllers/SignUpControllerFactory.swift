import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeSignUpController() -> SignUpViewController {
    makeSignUpControllerWith(getCookie: makeRemoteGetCookie())
}

public func makeSignUpControllerWith(getCookie: GetCookie) -> SignUpViewController {
    let controller = SignUpViewController.instanciate()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), getCookie: getCookie, loadingView: WeakVarProxy(controller), validation: validationComposite)
    controller.signUp = presenter.signUp
    
    return controller
}

public func makeSignUpValidations() -> [Validation] {
    return ValidationBuilder.field("category").label("Category").required().build() +
        ValidationBuilder.field("email").label("Email").required().email().build() +
        ValidationBuilder.field("password").label("Password").required().build() +
        ValidationBuilder.field("passwordConfirmation").label("Password").sameAs("password").build()
}
