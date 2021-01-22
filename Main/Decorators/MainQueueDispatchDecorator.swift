import Foundation
import Domain

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
