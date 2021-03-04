import Foundation

public final class LoginRouter {
    private let nav: NavigationController
    private let fortuneFactory: () -> FortuneViewController
    
    public init(nav: NavigationController, fortuneFactory: @escaping () -> FortuneViewController) {
        self.nav = nav
        self.fortuneFactory = fortuneFactory
    }
    
    public func goToFortune() {
        nav.pushViewController(fortuneFactory())
    }
}
