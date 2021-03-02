//
//  TestFactories.swift
//  DataTests
//
//  Created by arthur takahashi on 15/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation

public func makeURL() -> URL {
    return URL(string: "http://yerkee.com/api/fortune/all")!
}

public func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

public func makeEmptyData() -> Data {
    return Data()
}

public func makeGetCookieValidData() -> Data {
    return Data("{\"fortune\":\"any_fortune\"}".utf8)
}

public func makeSignUpValidData() -> Data {
    return Data("{\"email\":\"any@any.com\",\"password\":\"any_password\",\"name\":\"any_name\",\"passwordConfirmation\":\"any_password\"}".utf8)
}

public func makeError() -> NSError {
    return NSError(domain: "default_error", code: 100)
}

public func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}
