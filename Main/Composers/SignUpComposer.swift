import Foundation
import Domain
import UI
import Domain
import Presentation
import Validation
import Infra

public final class SignUpComposer {
    public static func composeControllerWith(getCookie: GetCookie) -> SignUpViewController {
        let controller = SignUpViewController.instanciate()
        let validationComposite = ValidationComposite(validations: makeValidations())
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), getCookie: getCookie, loadingView: WeakVarProxy(controller), validation: validationComposite)
        controller.signUp = presenter.signUp
        
        return controller
    }
    
    public static func makeValidations() -> [Validation] {
        return [
            RequiredFieldValidation(fieldName: "category", fieldLabel: "Category"),
            CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter())
        ]
    }
}
