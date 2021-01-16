//
//  InfraTests.swift
//  InfraTests
//
//  Created by arthur takahashi on 14/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import XCTest
@testable import Infra
import Alamofire
import Data

class AlamofireAdapterTests: XCTestCase {

    func test_get_should_make_request_with_valid_url_and_method() {
        let url = makeURL()
        testRequestFor(url: url) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
        }
    }
    
    func test_get_should_make_request_with_no_data() {
        testRequestFor() { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_get_should_complete_with_error_wuen_request_finish_with_error() {
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError())  )
    }
    
    func test_get_should_complete_with_error_on_all_invalid_cases() {
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
        
    }
    
    func test_get_should_complete_with_data_when_request_completes_with_ok_200() {
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil))
    }
    
    func test_get_should_complete_with_no_data_when_request_completes_with_ok_204() {
        expectResult(.success(nil), when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))

    }
    
    func test_get_should_complete_with_data_when_request_completes_with_nok() {
        /*
         Valid/Invalid Request Return:
         
                    data  response    error
         valid      OK      OK          X
         valid      X       X           OK
         invalid    OK      OK          OK
         invalid    OK      X           OK
         invalid    OK      X           X
         invalid    X       OK          OK
         invalid    X       OK          X
         invalid    X       X           X
                                            */
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 404), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.get(from: makeURL()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)): XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("Expect \(expectedResult) got \(receivedResult) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
    
}

extension AlamofireAdapterTests {
    
    func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut)
        return sut
    }
    
    func testRequestFor(url: URL = makeURL(), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.get(from: makeURL()) {_ in exp.fulfill()}
        var request: URLRequest?
        UrlProtocolStub.observerRequest{ request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
}

