
import Foundation

protocol GetCookie {
    func get(getCookieModel: GetCookieModel, completion:  @escaping (Result<CookieModel, Error>) -> Void)
}

struct GetCookieModel {
    var fortune : String
}

public struct CookieModel {
    var fortune : String
    
    init() {
        self.fortune = ""
    }
}

