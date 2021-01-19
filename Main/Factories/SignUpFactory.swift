import Foundation
import UI
import Presentation
import Data
import Infra

class SignUpFactory {
    static func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instanciate()
        let url = URL(string: "http://yerkee.com/api/fortune/all")!
        let alamofireAdapter = AlamofireAdapter()
        let remoteGetCookie = RemoteGetCookie(url: url, httpClient: alamofireAdapter)
        let presenter = SignUpPresenter(alertView: controller, getCookie: remoteGetCookie, loadingView: controller)
        controller.signUp = presenter.signUp
        
        return controller
    }
}
