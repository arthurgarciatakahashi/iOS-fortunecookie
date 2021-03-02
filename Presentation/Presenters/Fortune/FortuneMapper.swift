import Foundation
import Domain

public final class FortuneMapper {
    static func toGetCookieModel(viewModel: FortuneRequest) -> GetCookieModel {
        return GetCookieModel(category: viewModel.category)
    }
}
