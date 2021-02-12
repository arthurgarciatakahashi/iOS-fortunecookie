import XCTest
import Main
import UI
import Validation

class SignUpControllerFactoryTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, getCookieSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        DispatchQueue.global().async {
            getCookieSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        checkMemoryLeak(for: sut)
        wait(for: [exp], timeout: 1)
    }
    func test_signUp_compose_with_correct_validations() {
        let validation = makeSignUpValidations()
        XCTAssertEqual(validation[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "category", fieldLabel: "Category"))
        
        XCTAssertEqual(validation[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        
        XCTAssertEqual(validation[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        
        XCTAssertEqual(validation[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Password"))
        
        XCTAssertEqual(validation[4] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "passwordConfirmation", fieldNameToCompare: "password", fieldLabel: "Password"))
        

    }
}

extension SignUpControllerFactoryTests {
    func makeSut() -> (sut: SignUpViewController, getCookieSpy: GetCookieSpy) {
        let getCookieSpy = GetCookieSpy()
        let sut = makeSignUpControllerWith(getCookie: MainQueueDispatchDecorator( getCookieSpy))
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: getCookieSpy)
        return (sut, getCookieSpy)
    }
}
