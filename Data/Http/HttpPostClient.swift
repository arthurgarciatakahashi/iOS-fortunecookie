import Foundation
import Domain

public protocol HttpPostClient {
    func post(from url: URL, with: AuthenticationModel?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
