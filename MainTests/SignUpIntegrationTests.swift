import XCTest
import Main

class SignUpIntegrationTests: XCTestCase {

    func test_ui_presentation_integration() throws {
        debugPrint("===============================")
        debugPrint(Environment.variable(.apiBaseURl))
        debugPrint("===============================")
        let sut = SignUpComposer.composeControllerWith(getCookie: GetCookieSpy())
        checkMemoryLeak(for: sut)
    }

}
