import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request(headers: HTTPHeaders)
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var task: HTTPTask { get }
}

extension Endpoint {
    var baseURL: URL {
        let urlStr = "https://random-data-api.com/api/v2"
        guard let url = URL(string: urlStr) else {
            fatalError("Not a valid URL")
        }
        return url
    }
}
