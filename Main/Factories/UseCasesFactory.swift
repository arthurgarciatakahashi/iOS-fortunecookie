import Foundation
import Data
import Infra
import Domain

public final class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Environment.variable(.apiBaseURl)
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    static func makeRemoteGetCookie() -> GetCookie {
        return RemoteGetCookie(url: makeUrl(path: "all"), httpClient: httpClient)
    }
}

public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    internal func dispatch(completion: @escaping ()-> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

extension MainQueueDispatchDecorator: GetCookie where T: GetCookie {
    public func get(completion: @escaping (Result<CookieModel, DomainError>) -> Void) {
        instance.get() { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}


