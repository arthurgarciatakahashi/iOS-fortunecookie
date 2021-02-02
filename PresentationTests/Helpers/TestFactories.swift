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

func makeSignUpViewModel(categoryType: CategoryType? = nil) -> SignUpViewModel {
    return SignUpViewModel(category: categoryType)
}

func makeLoginViewModel(email: String? = "any@any.com", password: String? = "any_password") -> LoginViewModel {
    return LoginViewModel(email: email, password: password)
}
