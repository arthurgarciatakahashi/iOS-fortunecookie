//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by arthur takahashi on 15/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import XCTest
import Data
import Infra
import Domain

class SignInIntegrationTests: XCTestCase {

    func test_login_with_account() throws {
        let url = URL(string: "https://fordevs.herokuapp.com/api/login")!
        let alamofireAdapter = AlamofireAdapter()
        /* the email must be previously registered with sign up api*/
        let authenticationModel = AuthenticationModel(email: "arth.developer@gmail.com", password: "any_password")
        let sut = RemoteAuthentication(url: url, httpClient: alamofireAdapter)
        let exp = expectation(description: "waiting")
        
        sut.auth(authenticationModel: authenticationModel) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
