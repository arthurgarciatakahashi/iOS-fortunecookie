import Foundation
import Domain

public class LoginPresenter {
    private let alertView: AlertView
//    private let loadingView: LoadingView
    private let validation: Validation
    private let authentication: Authentication
    
    public init(alertView: AlertView, authentication: Authentication, validation: Validation) {
        self.alertView = alertView
//        self.getCookie = getCookie
//        self.loadingView = loadingView
        self.validation = validation
        self.authentication = authentication

    }
    
    public func login(viewModel: LoginViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: message))
        } else {
            authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { _ in
                
            }
        }
    }
}
