
import XCTest
import Validation
import Presentation


class RequiredFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() {
        let sut = makeSut(fieldName: "category", fieldLabel: "Category")
        let errorMessage = sut.validate(data:["category": ""])
        XCTAssertEqual(errorMessage, "Category is required")
    }
    func test_validate_should_return_error_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "age", fieldLabel: "Age")
        let errorMessage = sut.validate(data:["category": ""])
        XCTAssertEqual(errorMessage, "Age is required")
    }
    func test_validate_should_return_nil_if_field_is_provided() {
        let sut = makeSut(fieldName: "category", fieldLabel: "Category")
        let errorMessage = sut.validate(data:["category": "winsdom"])
        XCTAssertNil(errorMessage)
    }
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "category", fieldLabel: "Category")
        let errorMessage = sut.validate(data:nil)
        XCTAssertEqual(errorMessage, "Category is required")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
