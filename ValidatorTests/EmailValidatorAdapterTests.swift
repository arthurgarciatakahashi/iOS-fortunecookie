import XCTest
//@testable import EmailValidatorAdapter

import Presentation
public class EmailValidatorAdapter: EmailValidator {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0,lenght: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
}
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
