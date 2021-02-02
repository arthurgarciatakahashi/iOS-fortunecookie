import Foundation
import Domain

public protocol HttpPostClient {
    func post(from url: URL, with: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void)
}
