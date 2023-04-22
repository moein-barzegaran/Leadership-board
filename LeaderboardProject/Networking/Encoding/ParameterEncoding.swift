import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding

    func encode(urlRequest: inout URLRequest,
                bodyParameters: Parameters?,
                urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParams = urlParameters else {
                    return
                }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParams)
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else {
                    return
                }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch let error {
            print(error)
        }
    }
}


