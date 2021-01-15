//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by arthur takahashi on 15/01/21.
//  Copyright © 2021 Arthur Takahashi. All rights reserved.
//

import Foundation
import Data

class HttpClientSpy: HttpGetClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data, HttpError>) -> Void)?
    
    func get(from url: URL, completion: @escaping (Result<Data, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = Data("{\"fortune\":\"any_fortune\"}".utf8)
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
        
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
