import Foundation
import Data
import Domain

func makeRemoteGetCookie(httpClient: HttpGetClient) -> GetCookie {
    let remoteGetCookie = RemoteGetCookie(url: makeApiUrl(path: "all"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteGetCookie)
}
