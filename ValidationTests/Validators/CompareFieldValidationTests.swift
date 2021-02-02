
import XCTest
import Validation
import Presentation


class CompareFieldValidationTests: XCTestCase {
    func test_validate_should_return_error_if_field_is_not_provided() {
        
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Password")
        let errorMessage = sut.validate(data:["password": "123", "passwordConfirmation": "124"])
        XCTAssertEqual(errorMessage, "Password is invalid")
    }
    func test_validate_should_return_error_with_correct_fieldLabel() {
        
        let sut = makeSut(fieldName: "anyLabel", fieldNameToCompare: "AnyLabelToCompare", fieldLabel: "Confirm")
        let errorMessage = sut.validate(data:["anyLabel": "123456", "AnyLabelToCompare": ""])
        XCTAssertEqual(errorMessage, "Confirm is invalid")
    }
    func test_validate_should_return_nil_if_comparation_succeeds() {
        let sut = makeSut(fieldName: "category", fieldNameToCompare: "categoryToCompare", fieldLabel: "Category")
        let errorMessage = sut.validate(data:["category": "winsdom", "categoryToCompare" : "winsdom"])
        XCTAssertNil(errorMessage)
    }
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "category", fieldNameToCompare: "", fieldLabel: "Category")
        let errorMessage = sut.validate(data:nil)
        XCTAssertEqual(errorMessage, "Category is invalid")
    }
}

extension CompareFieldValidationTests {
    func makeSut(fieldName: String, fieldNameToCompare: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = CompareFieldsValidation(fieldName: fieldName, fieldNameToCompare: fieldNameToCompare, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
