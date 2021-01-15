import Foundation
import Domain

public final class RemoteGetCookie {
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url : URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func get() -> GetCookieModel? {
        let getCookieModel = GetCookieModel()
        let data = self.httpClient.get(from: url)
        let cookie = getCookieModel.convertFromData(data)
        return cookie
    }
}
