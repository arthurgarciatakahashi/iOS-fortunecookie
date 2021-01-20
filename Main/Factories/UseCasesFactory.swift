import Foundation
import Data
import Infra
import Domain

public final class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = "http://yerkee.com/api/fortune"
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    
    static func makeRemoteGetCookie() -> GetCookie {
        return RemoteGetCookie(url: makeUrl(path: "all"), httpClient: httpClient)
    }
}
