import XCTest
@testable import Presentation
import Domain
import Data

class SignUpPresenterTests: XCTestCase {
    
    func test_signup_should_show_success_message_when_addAccount_succeeds() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeSuccessAlertViewModel(message: "Account has been created"))
            exp.fulfill()
        }

        sut.signUp(viewModel: makeSignUpViewModel())
        addAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1)
    }

    func test_signup_should_call_addAccount_with_no_errors() throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }

    func test_signup_should_show_error_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let signUpViewModel = makeSignUpViewModel()
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message:"Unexpected error, try again in a few minutes"))
            exp.fulfill()
        }

        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }

    func test_signup_should_show_error_message_if_addAccount_returns_api_error() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let signUpViewModel = makeSignUpViewModel()
        let exp = expectation(description: "waiting")

        alertViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message:"Email in use, try another one"))
            exp.fulfill()
        }

        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.emailInUse)
        wait(for: [exp], timeout: 1)
    }
//
//    func test_signup_should_show_loading_before_and_after_call_getCookie() throws {
//        let loadingViewSpy = LoadingViewSpy()
//        let getCookieSpy = GetCookieSpy()
//        let sut = makeSut(getCookieSpy: getCookieSpy, loadingView: loadingViewSpy)
//
//        let exp = expectation(description: "waiting")
//
//        loadingViewSpy.observer { viewModel in
//            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
//            exp.fulfill()
//        }
//
//        sut.signUp(viewModel: makeSignUpViewModel(categoryType: .all))
//        wait(for: [exp], timeout: 1)
//
//        let exp2 = expectation(description: "waiting")
//
//        loadingViewSpy.observer { viewModel in
//            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
//            exp2.fulfill()
//        }
//
//        getCookieSpy.completeWithError(.unexpected)
//        wait(for: [exp2], timeout: 1)
//    }
//
//    func test_signUp_should_call_validation_with_correct_values() {
//        let validationSpy = ValidationSpy()
//        let viewModel = makeSignUpViewModel()
//        let sut = makeSut(validation: validationSpy)
//        sut.signUp(viewModel: viewModel)
//
//        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
//    }
//
//    func test_signup_should_show_error_message_if_validation_fails() throws {
//        let alertViewSpy = AlertViewSpy()
//        let validationSpy = ValidationSpy()
//        let sut = makeSut(alertViewSpy: alertViewSpy, validation: validationSpy)
//        let exp = expectation(description: "waiting")
//        alertViewSpy.observer { viewModel in
//            XCTAssertEqual(viewModel, makeErrorAlertViewModel(message: "Error"))
//            exp.fulfill()
//        }
//        validationSpy.simulateError()
//        sut.signUp(viewModel: makeSignUpViewModel())
//        wait(for: [exp], timeout: 1)
//    }
}

extension SignUpPresenterTests {
    
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(), addAccountSpy: AddAccountSpy = AddAccountSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), validation: ValidationSpy = ValidationSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy, addAccount: addAccountSpy, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut)
        return sut
    }
}
