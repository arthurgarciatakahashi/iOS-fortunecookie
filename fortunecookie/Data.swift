//
//  Data.swift
//  fortunecookie
//
//  Created by arthur takahashi on 06/08/20.
//  Copyright © 2020 Arthur Takahashi. All rights reserved.
//

import Foundation
class Data : ObservableObject{
    
    let host: String = "http://yerkee.com/api/fortune/all"
    @Published var cookieMessage :String = "waiting..."
    
    struct FortuneResponse : Codable {
        var fortune : String
    }
    
    public func getCookieMessage() -> String {
        print("0")
        return self.cookieMessage
    }
    
    func setCookieMessage(value : String) {
        self.cookieMessage = value
    }

    func getJson() {
        guard let url = URL(string: host) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(FortuneResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.setCookieMessage(value: decodedData.fortune)
                        print("1")
                    }
                    print("2")
                }
            }
        }.resume()
    }
    
}
