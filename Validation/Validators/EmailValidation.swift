import Foundation
import Presentation

public final class EmailValidation: Validation, Equatable {
    var fieldName: String
    var fieldLabel: String
    var emailValidator: EmailValidator
    
    public init(fieldName: String, fieldLabel: String, emailValidator: EmailValidator) {
        self.emailValidator = emailValidator
        self.fieldLabel = fieldLabel
        self.fieldName = fieldName
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String, emailValidator.isValid(email: fieldValue) else {
            return "\(fieldLabel) is invalid"
        }
        return nil
    }
    public static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
}
