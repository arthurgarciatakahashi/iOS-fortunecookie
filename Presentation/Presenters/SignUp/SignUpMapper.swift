import Foundation
import Domain

public final class SignUpMapper {
    static func toAddCookieModel(viewModel: SignUpViewModel) -> GetCookieModel {
        return GetCookieModel(category: viewModel.category)
    }
}
