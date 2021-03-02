import Foundation
import Domain

public class SignUpPresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let addAccount : AddAccount
    private let validation: Validation
    
    public init(alertView: AlertView, addAccount: AddAccount, loadingView: LoadingView, validation: Validation) {
        self.alertView = alertView
        self.addAccount = addAccount
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func signUp(viewModel: SignUpRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            //let addAccountModel = SignUpMapper.toAddAccountModel(viewModel: viewModel)
            
            addAccount.add(addAccountModel: viewModel.toAddAccountModel()) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    switch error {
                    case .emailInUse:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "email in use, try another one"))
                    case .expiredSession:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Incorrect email or password"))
                    default:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Unexpected error, try again in a few minutes"))
                    }
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Account has been created"))
                    
                }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            }
        }
    }
}
