import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeSignUpController() -> SignUpViewController {
    makeSignUpController(getCookie: makeRemoteGetCookie())
}

public func makeSignUpController(getCookie: GetCookie) -> SignUpViewController {
    let controller = SignUpViewController.instanciate()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), getCookie: getCookie, loadingView: WeakVarProxy(controller), validation: validationComposite)
    controller.signUp = presenter.signUp
    
    return controller
}

public func makeSignUpValidations() -> [Validation] {
    return [
        RequiredFieldValidation(fieldName: "category", fieldLabel: "Category"),
        CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: makeEmailValidatorAdapter())
    ]
}
