import Foundation
import Domain

public final class SignUpMapper {
    static func toGetCookieModel(viewModel: SignUpRequest) -> GetCookieModel {
        return GetCookieModel(category: viewModel.category)
    }
}
