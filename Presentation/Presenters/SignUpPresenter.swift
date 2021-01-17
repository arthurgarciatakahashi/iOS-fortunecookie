//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by arthur takahashi on 16/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation
import Domain

public class SignUpPresenter {
    private let alertView: AlertView
    private let getCookie : GetCookie
    
    public init(alertView: AlertView, getCookie: GetCookie) {
        self.alertView = alertView
        self.getCookie = getCookie
    }
    
    public func signUp(viewModel: SignUpViewModel) {
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation Failed", message: message))
        } else {
            //let getCookieModel = GetCookieModel(category: viewModel.category)
            getCookie.get() { result in
                switch result {
                case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "unexpected error, try again in a few minutes"))
                case .success: break
                
                }
            }
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.category == nil {
            return "category is required"
        }
        return nil
    }
}

public struct SignUpViewModel {
    public init(category: CategoryType? = nil) {
        self.category = category
    }
    
    public var category: CategoryType?
}
