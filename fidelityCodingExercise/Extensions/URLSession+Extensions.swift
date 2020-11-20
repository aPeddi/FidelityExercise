import Foundation
import Combine

enum RequestError: Error {
    case request(code: Int, error: Error?)
    case cannotParse
    case unknown
}

extension URLSession {
	
	/// Sends API Request and publishes the Response
	/// - Parameter request: API Request
	/// - Returns: Publisher with Response Data/Error
    func send(request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                let httpResponse = response as? HTTPURLResponse
				///Success Case
                if let httpResponse = httpResponse, 200..<300 ~= httpResponse.statusCode {
                    return data
                }
                else if let httpResponse = httpResponse {
					///Failure Case
                    throw RequestError.request(code: httpResponse.statusCode, error: NSError(domain: httpResponse.description, code: httpResponse.statusCode, userInfo: httpResponse.allHeaderFields as? [String : Any]))
                }     else {
                    throw RequestError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
