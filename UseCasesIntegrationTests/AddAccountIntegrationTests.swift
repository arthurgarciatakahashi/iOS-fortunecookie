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

class AddAccountIntegrationTests: XCTestCase {

    func test_add_account() throws {
        let url = URL(string: "https://fordevs.herokuapp.com/api/signup")!
        //let url_login = URL(string: "http: //fordevs.herokuapp.com/api/login")!
        let alamofireAdapter = AlamofireAdapter()
        let accountModel = AddAccountModel(name: "name", email: "\(UUID().uuidString)@gmail.com", password: "any_password", passwordConfirmation: "any_password")
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: accountModel) { result in
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
