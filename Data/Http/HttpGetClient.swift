import Foundation

public protocol HttpGetClient {
    func get(from url: URL) -> Data?
}
