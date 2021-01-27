//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by arthur takahashi on 22/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import XCTest
import Presentation
import Validation

class EmailValidationTests: XCTestCase {

    func test_validate_should_return_if_invalid_email_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        
        XCTAssertEqual(errorMessage, "Email is invalid")
    }
    func test_validate_should_return_error_with_correct_fieldLabel() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = EmailValidation(fieldName: "email", fieldLabel: "Label", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let errorMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        
        XCTAssertEqual(errorMessage, "Label is invalid")
    }
    func test_validate_should_return_nil_if_valid_email_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = EmailValidation(fieldName: "email", fieldLabel: "Label", emailValidator: emailValidatorSpy)
        let errorMessage = sut.validate(data: ["email": "valid_email@gmail.com"])
        
        XCTAssertNil(errorMessage)
    }
    func test_validate_should_return_nil_if_no_data_is_provided() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = EmailValidation(fieldName: "field", fieldLabel: "field", emailValidator: emailValidatorSpy)
        let errorMessage = sut.validate(data: nil)
        
        XCTAssertEqual(errorMessage, "field is invalid")
    }
}

extension EmailValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidatorSpy, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
