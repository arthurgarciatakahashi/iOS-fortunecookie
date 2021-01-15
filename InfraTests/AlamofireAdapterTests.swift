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

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: .get).resume().responseData() { dataResponse in
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success: break
            }
        }
    }
}

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
    
    func test_get_should_complete_with_error_quen_request_finish_with_error() {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: nil, response: nil, error: makeError())
        let exp = expectation(description: "waiting")
        sut.get(from: makeURL()) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .noConnectivity)
            case .success: XCTFail("Expect error got \(result) instead")
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
        sut.get(from: makeURL()) {_ in }
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observerRequest(completion: { request in
            action(request)
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
    }
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var error: Error?
    static var data: Data?
    static var response: HTTPURLResponse?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        /*setado como true intercepta todas as chamadas*/
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
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
        return request
    }
    
    override open func startLoading() {
        UrlProtocolStub.emit?(request)
        
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override open func stopLoading() {
        
    }
}
