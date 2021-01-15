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
