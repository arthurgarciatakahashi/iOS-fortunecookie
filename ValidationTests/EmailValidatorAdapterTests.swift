import XCTest
@testable import Validation


class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() throws {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: ""))
        XCTAssertFalse(sut.isValid(email: "onlyletter@"))
        XCTAssertFalse(sut.isValid(email: "letters@letters"))
        XCTAssertFalse(sut.isValid(email: "letters@letters."))
        XCTAssertFalse(sut.isValid(email: "@letters.com"))
    }
    func test_valid_emails() throws {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "arthurgt@alumni.usp.br"))
        XCTAssertTrue(sut.isValid(email: "arthurgt@usp.br@"))
        XCTAssertTrue(sut.isValid(email: "arthurgt@test.com.br"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
