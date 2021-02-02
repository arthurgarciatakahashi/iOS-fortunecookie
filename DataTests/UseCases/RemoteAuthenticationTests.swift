import XCTest
import Domain
@testable import Data

class RemoteAuthenticationTests: XCTestCase {

    func test_auth_should_call_httpGetClient_with_correct_url() {
        let url = makeURL()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth(authenticationModel: makeAuthenticationModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_auth_should_call_httpClient_with_a_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.auth(authenticationModel: authenticationModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }
    
    func test_auth_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_auth_should_complete_with_expired_error_if_client_completes_with_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.expiredSession)) {
            httpClientSpy.completeWithError(.unauthorized)
        }
    }
    
    func test_auth_should_complete_with_account_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account), when: {
            httpClientSpy.completeWithData(account.toData()!)
        })
    }
}

extension RemoteAuthenticationTests {
    
    func makeSut(url: URL = URL(string: "http://yerkee.com/api/fortune/all")!) -> (sut: RemoteAuthentication, httpClientSpy: HttpPostClientSpy) {
        let httpClientSpy = HttpPostClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)

        return (sut, httpClientSpy)
    }
    func expect(_ sut: RemoteAuthentication, completeWith expectResult: Authentication.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(authenticationModel: makeAuthenticationModel()) { receivedResult in
            switch (expectResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedCookie), .success(let receivedCookie)): XCTAssertEqual(expectedCookie, receivedCookie, file: file, line: line)
            default: XCTFail("expected \(expectResult) but received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
