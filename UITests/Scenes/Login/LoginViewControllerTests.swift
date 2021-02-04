import XCTest
import UIKit
import Presentation
@testable import UI

class LoginViewControllerTests: XCTestCase {

    func test_login_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_login_sut_implements_loadingView() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_login_sut_implements_alertView() throws {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_login_button_calls_login_on_tap() {
        var loginViewModel: LoginViewModel?
        let sut = makeSut(loginSpy: { loginViewModel = $0})
        sut.loginButton?.simulateTap()
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        
        XCTAssertEqual(loginViewModel, LoginViewModel(email: email, password: password))
    }
}

extension LoginViewControllerTests {
    func makeSut(loginSpy: ((LoginViewModel) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController.instanciate()
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)

        return sut
    }
}
