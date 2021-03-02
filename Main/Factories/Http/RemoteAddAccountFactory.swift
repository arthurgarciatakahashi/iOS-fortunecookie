import Foundation
import Data
import Domain

func makeRemoteAddAccount() -> AddAccount {
    makeRemoteAddAccountWith(httpClient: makeAlamofireAdapter())
}

func makeRemoteAddAccountWith(httpClient: HttpPostClient) -> AddAccount {
    let remoteAddAccount = RemoteAddAccount(url: makeApiUrl(path: "all"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAddAccount)
}
