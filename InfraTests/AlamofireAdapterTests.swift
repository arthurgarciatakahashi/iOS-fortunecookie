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

class AlamofireAdapter {
    
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.request(url, method: .get).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_get_should_make_request_with_valid_url_and_method() {
        let url = makeURL()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.get(from: url)
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observerRequest(completion: { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)

            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
    }
    
    func test_get_should_make_request_with_no_data() {
        let url = makeURL()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        sut.get(from: url)
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observerRequest(completion: { request in
            XCTAssertNil(request.httpBodyStream)
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
    }
    
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        //setado como true intercepta todas as chamadas
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override open func startLoading() {
        UrlProtocolStub.emit?(request)
    }
    
    override open func stopLoading() {
        
    }
}
