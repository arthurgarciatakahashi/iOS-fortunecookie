import XCTest
@testable import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {

    func test_signup_should_show_error_message_if_category_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeRequiredAlertViewModel(fieldName: "category"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_not_show_alert_error_with_computers_type() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let signUpViewModel = makeSignUpViewModel(categoryType: .computers)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer {viewModel in
            XCTAssertEqual(viewModel, nil)
            exp.fulfill()
        }
        
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [exp], timeout: 1)
    }

    func test_signup_should_call_getCookie_with_no_errors() throws {
        let getCookieSpy = GetCookieSpy()
        let sut = makeSut(getCookieSpy: getCookieSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(getCookieSpy.getCookieModel, makeGetCookieModel())
    }
    
    func test_signup_should_show_error_message_if_getCookide_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let getCookieSpy = GetCookieSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, getCookieSpy: getCookieSpy)
        let signUpViewModel = makeSignUpViewModel(categoryType: .all)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel,self?.makeErrorAlertViewModel(message:"unexpected error, try again in a few minutes"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: signUpViewModel)
        getCookieSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
}

extension SignUpPresenterTests {
    
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(),getCookieSpy: GetCookieSpy = GetCookieSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy, getCookie: getCookieSpy)
        
        return sut
    }
    
    func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
        //CategoryType will never be invalid cause its a enum
        return AlertViewModel(title: "Validation Failed", message: "\(fieldName) is invalid")
    }
    
    func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
        return AlertViewModel(title: "Validation Failed", message: "\(fieldName) is required")
    }
    
    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Error", message: message)
    }
    
    func makeSignUpViewModel(categoryType: CategoryType? = nil) -> SignUpViewModel {
        return SignUpViewModel(category: categoryType)
    }
    
    class AlertViewSpy: AlertView {
        var emit: ((AlertViewModel) -> Void)?
        
        func observer(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
        }
    }
}

class GetCookieSpy: GetCookie {
    let getCookieModel = GetCookieModel(category: .all)
    var completion: ((Result<CookieModel, DomainError>) -> Void)?
    
    func get(completion: @escaping (Result<CookieModel, DomainError>) -> Void) {
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
}
