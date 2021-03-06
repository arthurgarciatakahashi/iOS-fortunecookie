import XCTest
@testable import Presentation
import Domain
import Data

class SignUpPresenterTests: XCTestCase {

//    func test_signup_should_show_error_message_if_category_is_not_provided() throws {
//        let alertViewSpy = AlertViewSpy()
//        let sut = makeSut(alertViewSpy: alertViewSpy)
//        let exp = expectation(description: "waiting")
//        alertViewSpy.observer { viewModel in
//            XCTAssertEqual(viewModel, makeRequiredAlertViewModel(fieldName: "category"))
//            exp.fulfill()
//        }
//
//        sut.signUp(viewModel: makeSignUpViewModel())
//        wait(for: [exp], timeout: 1)
//    }
    
    func test_signup_should_show_success_message_when_getCookie_succeeds() throws {
        let alertViewSpy = AlertViewSpy()
        let getCookieSpy = GetCookieSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, getCookieSpy: getCookieSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "CooKie has been received"))
            exp.fulfill()
        }

        sut.signUp(viewModel: makeSignUpViewModel(categoryType: .all))
        getCookieSpy.completeWithCookie(makeCookieModel())
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

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message:"unexpected error, try again in a few minutes"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: signUpViewModel)
        getCookieSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_error_message_if_getCookide_returns_api_error() throws {
        let alertViewSpy = AlertViewSpy()
        let getCookieSpy = GetCookieSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, getCookieSpy: getCookieSpy)
        let signUpViewModel = makeSignUpViewModel(categoryType: .all)
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message:"API is busy, try again in a few minutes"))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: signUpViewModel)
        getCookieSpy.completeWithError(.apiInUse)
        wait(for: [exp], timeout: 1)
    }
    
    func test_signup_should_show_loading_before_and_after_call_getCookie() throws {
        let loadingViewSpy = LoadingViewSpy()
        let getCookieSpy = GetCookieSpy()
        let sut = makeSut(getCookieSpy: getCookieSpy, loadingView: loadingViewSpy)
        
        let exp = expectation(description: "waiting")

        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        
        sut.signUp(viewModel: makeSignUpViewModel(categoryType: .all))
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")

        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        
        getCookieSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    
    func test_signUp_should_call_validation_with_correct_values() {
        let validationSpy = ValidationSpy()
        let viewModel = makeSignUpViewModel()
        let sut = makeSut(validation: validationSpy)
        sut.signUp(viewModel: viewModel)
        
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
    
    func test_signup_should_show_error_message_if_validation_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Error"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(),getCookieSpy: GetCookieSpy = GetCookieSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy, getCookie: getCookieSpy, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut)
        return sut
    }
}
