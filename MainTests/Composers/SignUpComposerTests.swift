import XCTest
import Main
import UI

class SignUpComposerTests: XCTestCase {

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

}

extension SignUpComposerTests {
    func makeSut() -> (sut: SignUpViewController, getCookieSpy: GetCookieSpy) {
        let getCookieSpy = GetCookieSpy()
        let sut = SignUpComposer.composeControllerWith(getCookie: MainQueueDispatchDecorator( getCookieSpy))
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: getCookieSpy)
        return (sut, getCookieSpy)
    }
}
