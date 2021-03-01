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
        let accountModel = makeAddAccountModel()
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let exp = expectation(description: "waiting")
        
        sut.add(addAccountModel: accountModel) { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let token):
                XCTAssertNotNil(token.accessToken)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
