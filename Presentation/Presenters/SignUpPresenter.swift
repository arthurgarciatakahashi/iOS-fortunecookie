//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by arthur takahashi on 16/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation

public class SignUpPresenter {
    private let alertView: AlertView
    
    public init(alertView: AlertView) {
        self.alertView = alertView
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            self.alertView.showMessage(viewModel: AlertViewModel(title: "Validation Failed", message: message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.category == nil {
            return "category is required"
        }
        return nil
    }
}

public enum CategoryType: String {
    case all
    case bible
    case computers
    case cookie
    case definitions
    case miscellaneous
    case people
    case platitudes
    case politics
    case science
    case winsdom
}

public struct SignUpViewModel {
    public init(category: CategoryType? = nil) {
        self.category = category
    }
    
    public var category: CategoryType?
}
