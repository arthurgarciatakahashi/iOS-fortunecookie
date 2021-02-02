import Foundation
import Domain

public class LoginPresenter {
//    private let alertView: AlertView
//    private let loadingView: LoadingView
    private let validation: Validation
    
    public init(validation: Validation) {
//        self.alertView = alertView
//        self.getCookie = getCookie
//        self.loadingView = loadingView
        self.validation = validation

    }
    
    public func login(viewModel: LoginViewModel) {
        _ = Validation.validate(data: viewModel.toJson())
    }
}
