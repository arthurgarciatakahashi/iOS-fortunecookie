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

class WeakVarProxy<T : AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}
    
extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}
