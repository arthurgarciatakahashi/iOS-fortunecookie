import Foundation

public final class Environment {
    
    public enum EnvironmentVariables: String {
        case apiBaseURl = "API_BASE_URL"
        case apiSignUpURl = "API_SIGNUP_URL"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return Bundle.main.infoDictionary?[key.rawValue] as! String
    }
}
