import XCTest
import Domain
@testable import Data

class RemoteAddAccountTests: XCTestCase {

    func test_add_should_call_httpPostClient_with_correct_url() {
        let url = makeURL()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }

    func test_add_should_call_httpClient_with_a_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }

        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }

    func test_add_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }

    func test_add_should_complete_with_expired_error_if_client_completes_with_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.expiredSession)) {
            httpClientSpy.completeWithError(.unauthorized)
        }
    }

    func test_add_should_complete_with_account_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account), when: {
            httpClientSpy.completeWithData(account.toData()!)
        })
    }

    func test_add_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }

    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpPostClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeURL(), httpClient: httpClientSpy)
        var result: AddAccount.Result?

        sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteAddAccountTests {
    
    func makeSut(url: URL = URL(string: "http://fordevs.herokuapp.com/api/signup")!) -> (sut: RemoteAddAccount, httpClientSpy: HttpPostClientSpy) {
        let httpClientSpy = HttpPostClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)

        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAddAccount, completeWith expectResult: AddAccount.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
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
