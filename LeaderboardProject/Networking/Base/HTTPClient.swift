import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

class MainHTTPClient: HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        do {
            let request = try self.buildRequest(from: endpoint)
            do {
                let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
                guard let response = response as? HTTPURLResponse else {
                    return .failure(.noResponse)
                }
                
                switch response.statusCode {
                case 200...299:
                    guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                        return .failure(.decode)
                    }
                    return .success(decodedResponse)
                default:
                    return .failure(.unexpectedStatusCode)
                }
            } catch let error {
                print(error)
                return .failure(.unknown)
            }
        } catch {
            return .failure(.requestBuild)
        }
    }
    
    fileprivate func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent("\(endpoint.path)"),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)

        request.timeoutInterval = 60
        request.httpMethod = endpoint.method.rawValue
        do {
            switch endpoint.task {
            case .request(let headers):
                self.addAdditionalHeaders(headers, request: &request)
            case let .requestParameters(bodyParameters,
                                        bodyEncoding,
                                        urlParameters):

                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)

            case let .requestParametersAndHeaders(bodyParameters,
                                                  bodyEncoding,
                                                  urlParameters,
                                                  additionalHeaders):

                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else {
            return
        }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
