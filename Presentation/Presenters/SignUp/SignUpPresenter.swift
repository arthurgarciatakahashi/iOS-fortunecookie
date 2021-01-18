import Foundation
import Domain

public class SignUpPresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let getCookie : GetCookie
    
    public init(alertView: AlertView, getCookie: GetCookie, loadingView: LoadingView) {
        self.alertView = alertView
        self.getCookie = getCookie
        self.loadingView = loadingView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation Failed", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            //let getCookieModel = GetCookieModel(category: viewModel.category)
            getCookie.get() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "unexpected error, try again in a few minutes"))
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "CooKie has been received"))
                
                }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))

            }
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.category == nil {
            return "category is required"
        }
        return nil
    }
}
