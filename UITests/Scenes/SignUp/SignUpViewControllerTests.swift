import XCTest
import UIKit
import Presentation
@testable import UI
import Domain

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() throws {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_saveButton_calls_signup_on_tap() {
        var signUpViewModel: SignUpViewModel?
        let sut = makeSut(signUpSpy: { signUpViewModel = $0})
        sut.saveButton?.simulateTap()
        let categoryType = CategoryType(rawValue: (sut.categoryTextField?.text)!)
        
        XCTAssertEqual(signUpViewModel, SignUpViewModel(category: categoryType))
    }
}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpViewModel) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController.instanciate()
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        
        return sut
    }
}
