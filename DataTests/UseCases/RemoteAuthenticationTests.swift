import XCTest
import Domain
@testable import Data

class RemoteAuthenticationTests: XCTestCase {

    func test_auth_should_call_httpGetClient_with_correct_url() {
        let url = makeURL()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth()
        XCTAssertEqual(httpClientSpy.urls, [url])
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
}
