import XCTest
@testable import Presentation

class SignUpPresenter {
    private let alertView: AlertView
    
    init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    func signUp(viewModel: SignUpViewModel) {
        if viewModel.category == nil || viewModel.category!.isEmpty {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation Failed", message: "Category is required"))
        }
    }
}

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable{
    var title: String
    var message: String
}

struct SignUpViewModel {
    var category: String?
}

class SignUpPresentationTests: XCTestCase {

    func test_signup_should_show_error_message_if_category_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        let signUpViewModel = SignUpViewModel(category: "any_category")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Validation Failed", message: "Category is required"))
    }
}

extension SignUpPresentationTests {
    class AlertViewSpy: AlertView {
        public var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
