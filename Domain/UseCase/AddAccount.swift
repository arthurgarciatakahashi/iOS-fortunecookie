import Foundation

public protocol AddAccount {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func add(addAccountModel: AddAccountModel, completion:  @escaping (Result) -> Void)
}

public struct AddAccountModel: Model {
    public init(name: String? = nil, email: String? = nil, password: String? = nil, confirmPassword: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    public var name: String?
    public var email: String?
    public var password: String?
    public var confirmPassword: String?

}
