import Foundation
import Data
import Infra
import Domain

public final class UseCaseFactory {
    static func makeRemoteGetCookie() -> GetCookie {
    let url = URL(string: "http://yerkee.com/api/fortune/all")!
    let alamofireAdapter = AlamofireAdapter()
    return RemoteGetCookie(url: url, httpClient: alamofireAdapter)
    }
}
