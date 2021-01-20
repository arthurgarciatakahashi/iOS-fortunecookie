import XCTest
import Main

class SignUpIntegrationTests: XCTestCase {

    func test_() throws {
        let sut = SignUpComposer.composeControllerWith(getCookie: GetCookieSpy())
        checkMemoryLeak(for: sut)
    }

}
