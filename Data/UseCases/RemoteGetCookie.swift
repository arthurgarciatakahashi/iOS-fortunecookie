import Foundation
import Domain

public final class RemoteGetCookie: GetCookie {
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url : URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func get(completion: @escaping (Result<CookieModel, DomainError>) -> Void) {
        self.httpClient.get(from: url) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
            case .success(let data):
                if let cookie : CookieModel = data?.toModel() {
                    completion(.success(cookie))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}
