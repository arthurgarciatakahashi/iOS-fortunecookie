import Foundation
import Domain
import UI
import Presentation
import Validation

public func makeFortuneController() -> FortuneViewController {
    makeFortuneControllerWith(getCookie: makeRemoteGetCookie())
}

public func makeFortuneControllerWith(getCookie: GetCookie) -> FortuneViewController {
    let controller = FortuneViewController.instanciate()
    let validationComposite = ValidationComposite(validations: makeFortuneValidations())
    let presenter = FortunePresenter(alertView: WeakVarProxy(controller), getCookie: getCookie, loadingView: WeakVarProxy(controller), validation: validationComposite)
    controller.fortune = presenter.fortune
    
    return controller
}

public func makeFortuneValidations() -> [Validation] {
    return ValidationBuilder.field("category").label("Category").required().build()
}
