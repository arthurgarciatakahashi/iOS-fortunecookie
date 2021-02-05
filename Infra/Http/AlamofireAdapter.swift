import Foundation
import Data
import Alamofire

public final class AlamofireAdapter: HttpGetClient, HttpPostClient {
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func post(from url: URL, with: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        
        session.request(url, method: .post, parameters: with).resume().responseData { _ in }
        
        session.request(url, method: .post).resume().responseData() { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else {
                return completion(.failure(.noConnectivity))
            }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204: completion(.success(nil))
                case 200...299: completion(.success(data))
                case 401: completion(.failure(.unauthorized))
                case 403: completion(.failure(.forbidden))
                case 400...499: completion(.failure(.badRequest))
                case 500...599: completion(.failure(.serverError))
                default: completion(.failure(.noConnectivity))
                }
            }
        }
    }
    
    public func get(from url: URL, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        session.request(url, method: .get).resume().responseData() { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else {
                return completion(.failure(.noConnectivity))
            }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                switch statusCode {
                case 204: completion(.success(nil))
                case 200...299: completion(.success(data))
                case 401: completion(.failure(.unauthorized))
                case 403: completion(.failure(.forbidden))
                case 400...499: completion(.failure(.badRequest))
                case 500...599: completion(.failure(.serverError))
                default: completion(.failure(.noConnectivity))
                }
            }
        }
    }
}
