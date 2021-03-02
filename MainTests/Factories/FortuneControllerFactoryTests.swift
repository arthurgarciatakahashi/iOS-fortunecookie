import XCTest
import Main
import UI
import Validation

class FortuneControllerFactoryTests: XCTestCase {

    func test_background_request_should_complete_on_main_thread() throws {
        let (sut, getCookieSpy) = makeSut()
        let exp = expectation(description: "waiting")
        sut.loadViewIfNeeded()
        sut.fortune?(makeFortuneViewModel())
        DispatchQueue.global().async {
            getCookieSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        checkMemoryLeak(for: sut)
        wait(for: [exp], timeout: 1)
    }
    func test_fortune_compose_with_correct_validations() {
        let validation = makeFortuneValidations()
        XCTAssertEqual(validation[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "category", fieldLabel: "Category"))
    }
}

extension FortuneControllerFactoryTests {
    func makeSut() -> (sut: FortuneViewController, getCookieSpy: GetCookieSpy) {
        let getCookieSpy = GetCookieSpy()
        let sut = makeFortuneControllerWith(getCookie: MainQueueDispatchDecorator( getCookieSpy))
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: getCookieSpy)
        return (sut, getCookieSpy)
    }
}
