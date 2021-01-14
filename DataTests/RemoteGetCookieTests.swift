import XCTest
@testable import Data

class RemoteGetCookie {
    private let url: URL
    private let httpClient: HttpGetClient
    
    init(url : URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func get() -> CookieModel {
        self.httpClient.get(url: url)
    }
}

protocol HttpGetClient {
    func get(url: URL) -> CookieModel
}

func makeURL() -> URL {
    return URL(string: "http://yerkee.com/api/fortune/all")!
}

class RemoteGetCookieTests: XCTestCase {

    func test_get_should_call_httpGetClient_with_correct_url() {
        let url = makeURL()
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteGetCookie(url: url, httpClient: httpClientSpy)
        let _ = sut.get()
        XCTAssertEqual(httpClientSpy.url, url)
    }
}

extension RemoteGetCookieTests {
    class HttpClientSpy: HttpGetClient {
        var url: URL?
        func get(url: URL) -> CookieModel {
            self.url = url
            var cookie = CookieModel()
            cookie.fortune = ""
            return cookie
        }
        
    }
}

