import Foundation
import Domain

public final class RemoteAddAccount: AddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url : URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(addAccountModel: AddAccountModel, completion: @escaping (Authentication.Result) -> Void) {
        httpClient.post(from: url, with: addAccountModel.toData()) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
            case .success(let data):
                if let model : AccountModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpectedReturn))
                }
            case .failure(let error):
                switch error {
                case .forbidden:
                    completion(.failure(.emailInUse))
                case .unauthorized:
                    completion(.failure(.expiredSession))

                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
