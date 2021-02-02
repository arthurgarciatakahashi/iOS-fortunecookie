import Foundation
import Domain

public class LoginPresenter {
    private let alertView: AlertView
//    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(alertView: AlertView, validation: Validation) {
        self.alertView = alertView
//        self.getCookie = getCookie
//        self.loadingView = loadingView
        self.validation = validation

    }
    
    public func login(viewModel: LoginViewModel) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: message))
        }
    }
}
