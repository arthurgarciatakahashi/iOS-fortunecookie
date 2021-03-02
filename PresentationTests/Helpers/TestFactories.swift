//
//  TestFactories.swift
//  PresentationTests
//
//  Created by arthur takahashi on 17/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation
import Presentation
import Domain

func makeInvalidAlertViewModel(fieldName: String) -> AlertViewModel {
    //CategoryType will never be invalid cause its a enum
    return AlertViewModel(title: "Validation Failed", message: "\(fieldName) is invalid")
}

func makeRequiredAlertViewModel(fieldName: String) -> AlertViewModel {
    return AlertViewModel(title: "Validation Failed", message: "\(fieldName) is required")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Error", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Success", message: message)
}

func makeSignUpViewModel(name: String? = "any_name", email: String? = "any@any.com", password: String? = "any_password", passwordConfirmation: String? = "any_password") -> SignUpRequest {
    return SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeFortuneViewModel(categoryType: CategoryType? = nil) -> FortuneRequest {
    return FortuneRequest(category: categoryType)
}

func makeLoginViewModel(email: String? = "any@any.com", password: String? = "any_password") -> LoginRequest {
    return LoginRequest(email: email, password: password)
}
