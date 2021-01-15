import XCTest
import Domain

@testable import Data

class RemoteGetCookieTests: XCTestCase {

    func test_get_should_call_httpGetClient_with_correct_url() {
        let url = makeURL()
        let (sut, httpClientSpy) = makeSut(url: url)
        let _ = sut.get()
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_get_should_gets_a_correct_cookie_model_data() {
        let (sut, httpClientSpy) = makeSut()
        let getCookieModel = makeGetCookieModel()
        let _ = sut.get()
        let data = getCookieModel.toData()
        XCTAssertEqual(httpClientSpy.data, data)
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
        var url: URL?
        var data: Data?
        
        func get(from url: URL) -> Data? {
            self.url = url
            self.data = Data("{\"fortune\":\"any_fortune\"}".utf8)
            return self.data
        }
    }
}

