import Foundation

func makeApiUrl(path: String) -> URL {
    switch path {
    case "signup", "login":
        return URL(string: "\(Environment.variable(.apiSignUpURl))/\(path)")!
    default:
        return URL(string: "\(Environment.variable(.apiBaseURl))/\(path)")!
    }
}
