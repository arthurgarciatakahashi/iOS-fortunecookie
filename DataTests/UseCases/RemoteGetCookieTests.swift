import XCTest
import Domain
@testable import Data

class RemoteGetCookieTests: XCTestCase {

    func test_get_should_call_httpGetClient_with_correct_url() {
        let url = makeURL()
        let (sut, httpClientSpy) = makeSut(url: url)
        let _ = sut.get() { _ in}
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_get_should_gets_a_correct_cookie_model_data() {
        let (sut, httpClientSpy) = makeSut()
        let getCookieModel = makeGetCookieModel()
        let _ = sut.get() { _ in}
        let data = getCookieModel.toData()
        XCTAssertEqual(httpClientSpy.data, data)
    }
    
    func test_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_should_complete_with_success_if_client_completes_returning_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let cookie = makeCookieModel()
        expect(sut, completeWith: .success(cookie)) {
            httpClientSpy.completeWithData(cookie.toData()!)
        }
    }
    
    func test_should_complete_with_error_if_client_completes_returning_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(makeInvalidData())
        }
    }
    
    func checkMemoryLeak(for instance: AnyObject) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance)
        }
    }
}

extension RemoteGetCookieTests {
    func makeURL() -> URL {
        return URL(string: "http://yerkee.com/api/fortune/all")!
    }

    func makeGetCookieModel() -> GetCookieModel {
        return GetCookieModel(fortune: "any_fortune")
    }
    
    func makeCookieModel() -> CookieModel {
        return CookieModel(fortune: "any_fortune")
    }
    
    func makeSut(url: URL = URL(string: "http://yerkee.com/api/fortune/all")!) -> (sut: RemoteGetCookie, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteGetCookie(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut)
        checkMemoryLeak(for: httpClientSpy)

        return (sut, httpClientSpy)
    }
    
    func makeData() -> Data? {
        return Data("any_fortune".utf8)
    }
    
    func makeInvalidData() -> Data {
        return Data("invalid_data".utf8)
    }
    
    func expect(_ sut: RemoteGetCookie, completeWith expectResult: Result<CookieModel, DomainError>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.get() { receivedResult in
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
    
    class HttpClientSpy: HttpGetClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func get(from url: URL, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = Data("{\"fortune\":\"any_fortune\"}".utf8)
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(.failure(error))
            
        }
        
        func completeWithData(_ data: Data) {
            completion?(.success(data))
        }
    }
}

