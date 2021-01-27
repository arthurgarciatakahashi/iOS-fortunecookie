import Foundation
import Domain

class GetCookieSpy: GetCookie {
    let getCookieModel = GetCookieModel(category: .all)
    var completion: ((GetCookie.Result) -> Void)?
    
    func get(completion: @escaping (GetCookie.Result) -> Void) {
        self.completion = completion
    }
    
    func completeWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completeWithCookie(_ cookie: CookieModel) {
        completion?(.success(cookie))
    }
}
