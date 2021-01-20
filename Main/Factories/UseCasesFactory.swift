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
