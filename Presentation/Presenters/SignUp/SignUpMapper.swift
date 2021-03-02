import Foundation
import Domain

public final class SignUpMapper {
    public func toAddAccountModel(viewModel: SignUpRequest) -> AddAccountModel {
        return AddAccountModel(name: viewModel.name, email: viewModel.email, password: viewModel.password, passwordConfirmation: viewModel.passwordConfirmation)
    }
}
