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
        if viewModel.category == nil || viewModel.category!.isEmpty {
            return "Category is required"
        }
        return nil
    }
}

public struct SignUpViewModel {
    public init(category: String? = nil) {
        self.category = category
    }
    
    public var category: String?
}
