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
            authentication.auth(authenticationModel: viewModel.toAuthenticationModel()) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .failure(let error):
                        switch error {
                        case .expiredSession:
                            self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Incorrect email or password"))
                        default:
                            self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Unexpected error, try again in a few minutes"))
                        }
                    case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Authentication OK"))
                    
                    }
                    //self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                
            }
        }
    }
}
