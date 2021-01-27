import Foundation
import Domain

public struct SignUpViewModel: Model {
    public init(category: CategoryType? = nil) {
        self.category = category
    }
    
    public var category: CategoryType?
    
    public func toGetCookieModel() -> GetCookieModel {
        guard self.category != nil else {
            return GetCookieModel()
        }
        return GetCookieModel(category: category)
    }
}
