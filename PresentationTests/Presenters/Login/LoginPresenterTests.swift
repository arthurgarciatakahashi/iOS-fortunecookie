import XCTest
import Presentation
import Domain

class LoginPresenterTests: XCTestCase {
    func test_() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }
}

extension LoginPresenterTests {
    func makeSut(validation: ValidationViewSpy = ValidationViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)

        return sut
    }
}
