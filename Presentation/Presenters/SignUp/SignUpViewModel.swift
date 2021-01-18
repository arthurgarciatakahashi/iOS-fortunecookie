import Foundation
import Domain

public struct SignUpViewModel {
    public init(category: CategoryType? = nil) {
        self.category = category
    }
    
    public var category: CategoryType?
}
