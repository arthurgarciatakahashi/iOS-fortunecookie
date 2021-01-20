import Foundation
import Domain
import UI
import Domain
import Presentation

public final class SignUpComposer {
    public static func composeControllerWith(getCookie: GetCookie) -> SignUpViewController {
        let controller = SignUpViewController.instanciate()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), getCookie: getCookie, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        
        return controller
    }
}
