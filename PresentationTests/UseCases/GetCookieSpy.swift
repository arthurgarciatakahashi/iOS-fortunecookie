import Foundation
import Domain

class GetCookieSpy: GetCookie {
    let getCookieModel = GetCookieModel(category: .all)
    var completion: ((Result<CookieModel, DomainError>) -> Void)?
    
    func get(completion: @escaping (Result<CookieModel, DomainError>) -> Void) {
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithCookie(_ cookie: CookieModel) {
        completion?(.success(cookie))
    }
}
