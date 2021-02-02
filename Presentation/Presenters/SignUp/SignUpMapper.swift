import Foundation
import Domain

public final class SignUpMapper {
    static func toGetCookieModel(viewModel: SignUpViewModel) -> GetCookieModel {
        return GetCookieModel(category: viewModel.category)
    }
}
