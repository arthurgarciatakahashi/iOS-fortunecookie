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

class RemoteGetCookieTests: XCTestCase {

    func test_() {
        let url = URL(string: "http://yerkee.com/api/fortune/all")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteGetCookie(url: url, httpClient: httpClientSpy)
        let _ = sut.get()
        XCTAssertEqual(httpClientSpy.url, url)
    }
}

class HttpClientSpy: HttpGetClient {
    var url: URL?
    func get(url: URL) -> CookieModel {
        self.url = url
        var cookie = CookieModel()
        cookie.fortune = ""
        return cookie
    }
    
}
