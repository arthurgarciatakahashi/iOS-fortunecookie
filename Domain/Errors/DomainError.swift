import Foundation

public enum DomainError: Error {
    case unexpected
    case unexpectedReturn
    case expiredSession
    case apiInUse
    case emailInUse
}
