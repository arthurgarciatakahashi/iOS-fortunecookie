import XCTest
import UIKit
import Domain
import Presentation
@testable import UI

class FortuneViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() throws {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_button_calls_fortune_cookie_message_on_tap() {
        var fortuneViewModel: FortuneRequest?
        let sut = makeSut(fortuneSpy: { fortuneViewModel = $0})
        sut.breakOpenButton?.simulateTap()
        let categoryType = CategoryType(rawValue: sut.categoryType)
        
        XCTAssertEqual(fortuneViewModel, FortuneRequest(category: categoryType))
    }
}

extension FortuneViewControllerTests {
    func makeSut(fortuneSpy: ((FortuneRequest) -> Void)? = nil) -> FortuneViewController {
        let sut = FortuneViewController.instanciate()
        sut.fortune = fortuneSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)

        return sut
    }
}
