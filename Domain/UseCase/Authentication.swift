import Foundation

public protocol Authentication {
    func add(authenticationModel: AuthenticationModel, completion:  @escaping (Result<AccountModel, DomainError>) -> Void)
}

public struct AuthenticationModel: Model {
    public var email: String?
    public var password: String?
    
    public init(email: String, password: String) {
        self.email = email
    }
}
