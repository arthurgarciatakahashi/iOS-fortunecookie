import Foundation
import UI
import Presentation
import Data
import Infra
import Domain

class ControllerFactory {
    static func makeSignUp(getCookie: GetCookie) -> SignUpViewController {
        let controller = SignUpViewController.instanciate()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), getCookie: getCookie, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        
        return controller
    }
}
