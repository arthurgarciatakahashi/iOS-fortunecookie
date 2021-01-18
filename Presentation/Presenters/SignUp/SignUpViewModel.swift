import Foundation
import Domain

public struct SignUpViewModel: Model {
    public init(category: CategoryType? = nil) {
        self.category = category
    }
    
    public var category: CategoryType?
}
