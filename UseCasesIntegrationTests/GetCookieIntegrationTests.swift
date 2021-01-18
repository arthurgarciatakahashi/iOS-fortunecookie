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

class GetCookieIntegrationTests: XCTestCase {

    func test_get_cookie() throws {
        let url = URL(string: "http://yerkee.com/api/fortune/all")!
        let alamofireAdapter = AlamofireAdapter()
        let sut = RemoteGetCookie(url: url, httpClient: alamofireAdapter)
        let exp = expectation(description: "waiting")
        
        sut.get() { result in
            switch result {
            case .failure: XCTFail("Expect success got \(result) instead")
            case .success(let cookie):
                XCTAssertNotNil(cookie.fortune)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }

}
