//
//  CookieModelFactory.swift
//  DataTests
//
//  Created by arthur takahashi on 15/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation
import Domain

func makeCookieModel() -> CookieModel {
    return CookieModel(fortune: "any_fortune")
}

func makeGetCookieModel() -> GetCookieModel {
    return GetCookieModel(category: .all)
}

func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(email: "any@any.com", password: "any_password")
}

func makeAccountModel() -> AccountModel {
    return AccountModel(accessToken: "accessToken")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "any_name", email: "any@any.com", password: "any_password", passwordConfirmation: "any_password"
    )
}
