import XCTest
import Domain
@testable import Data

class RemoteGetCookieTests: XCTestCase {

    func test_get_should_call_httpGetClient_with_correct_url() {
        let url = URL(string: "https://any_url.com")!
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
    
    func test_should_complete_with_error_if_client_fails() {
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "waiting")
        let _ = sut.get() { error in
            XCTAssertEqual(error, .unexpected)
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
}

extension RemoteGetCookieTests {
    func makeURL() -> URL {
        return URL(string: "http://yerkee.com/api/fortune/all")!
    }

    func makeGetCookieModel() -> GetCookieModel {
        return GetCookieModel(fortune: "any_fortune")
    }
    
    func makeSut(url: URL = URL(string: "http://yerkee.com/api/fortune/all")!) -> (sut: RemoteGetCookie, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteGetCookie(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeData() -> Data? {
        return Data("any_fortune".utf8)
    }
    
    class HttpClientSpy: HttpGetClient {
        var urls = [URL]()
        var data: Data?
        var completion: ((HttpError) -> Void)?
        
        func get(from url: URL, completion: @escaping (HttpError) -> Void) -> Data? {
            self.urls.append(url)
            self.data = Data("{\"fortune\":\"any_fortune\"}".utf8)
            self.completion = completion

            return self.data
        }
        
        func completeWithError(_ error: HttpError) {
            completion?(error)        }
    }
}

