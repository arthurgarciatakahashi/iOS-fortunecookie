import Foundation
import Domain

public class FortunePresenter {
    private let alertView: AlertView
    private let loadingView: LoadingView
    private let getCookie : GetCookie
    private let validation: Validation
    
    public init(alertView: AlertView, getCookie: GetCookie, loadingView: LoadingView, validation: Validation) {
        self.alertView = alertView
        self.getCookie = getCookie
        self.loadingView = loadingView
        self.validation = validation
    }
    
    public func fortune(viewModel: FortuneRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            getCookie.get() { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    switch error {
                    case .apiInUse:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "API is busy, try again in a few minutes"))
                    default:
                        self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "unexpected error, try again in a few minutes"))
                    }
                case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "CooKie has been received"))
                
                }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))

            }
        }
    }
}
