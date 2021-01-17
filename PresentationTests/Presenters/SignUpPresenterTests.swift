import XCTest
@testable import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {

    func test_signup_should_show_error_message_if_category_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeRequiredAlertViewModel(fieldName: "category"))
    }
    
    func test_signup_should_not_show_alert_error_with_computers_type() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(category: .computers)
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, nil)
    }
    
}

extension SignUpPresenterTests {
    
    func makeSut(_ alertViewSpy: AlertViewSpy = AlertViewSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy)
        
        return sut
    }
    
    func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
        //CategoryType will never be invalid cause its a enum
        return AlertViewModel(title: "Validation Failed", message: "\(fieldName) is invalid")
    }
    
    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Validation Failed", message: "\(fieldName) is required")
    }
    
    func makeSignUpViewModel(category: CategoryType? = nil) -> SignUpViewModel {
        return SignUpViewModel(category: category)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}

class getCookieSpy: GetCookie {
    func get(completion: @escaping (Result<CookieModel, DomainError>) -> Void) {
        /*
         It will not be used for now
        */
    }
}
