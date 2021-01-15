import Foundation

public protocol HttpGetClient {
    func get(from url: URL, completion: @escaping (HttpError) -> Void) -> Data?
}
