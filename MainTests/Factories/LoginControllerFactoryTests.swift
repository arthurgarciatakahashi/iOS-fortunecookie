import XCTest
import Main
import UI
import Validation

class LoginControllerFactoryTests: XCTestCase {

    func test_login_background_request_should_complete_on_main_thread() throws {
        let (sut, authenticationSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.loadViewIfNeeded()
        sut.login?(makeLoginViewModel())
        DispatchQueue.global().async {
            authenticationSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        checkMemoryLeak(for: sut)
        wait(for: [exp], timeout: 1)
    }
    func test_login_compose_with_correct_validations() {
        let validation = makeLoginValidations()
        XCTAssertEqual(validation[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        
        XCTAssertEqual(validation[1] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        
        XCTAssertEqual(validation[2] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"))
        

    }
}

extension LoginControllerFactoryTests {
    func makeSut() -> (sut: LoginViewController, authenticationSpy: AuthenticationSpy) {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeLoginController(authentication: MainQueueDispatchDecorator(authenticationSpy))
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: authenticationSpy)
        return (sut, authenticationSpy)
    }
}
