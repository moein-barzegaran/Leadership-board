import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest.httpBody = jsonAsData
        } catch {
            throw RequestError.encode
        }
    }
}
