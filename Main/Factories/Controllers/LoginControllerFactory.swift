import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeLoginController(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController.instanciate()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let presenter = LoginPresenter(alertView: WeakVarProxy(controller), authentication: authentication, validation: validationComposite, loadingView: WeakVarProxy(controller))
    
    controller.login = presenter.login
    
    return controller
}

public func makeLoginValidations() -> [Validation] {
    return [
        RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter()),
        RequiredFieldValidation(fieldName: "password", fieldLabel: "Password")
    ]
}
