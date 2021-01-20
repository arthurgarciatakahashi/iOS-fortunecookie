import Foundation
import Domain
import UI

public final class SignUpComposer {
    public static func composeControllerWith(getCookie: GetCookie) -> SignUpViewController {
        return ControllerFactory.makeSignUp(getCookie: getCookie)
    }
}
