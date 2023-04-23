enum LeadershipBoardEndpoint {
    case yourLocationUsers(size: Int)
    case globalUsers(size: Int)
    case friends(size: Int)
}

extension LeadershipBoardEndpoint: Endpoint {
    var task: HTTPTask {
        switch self {
        case let .yourLocationUsers(size), let .globalUsers(size), let .friends(size):
            let parameter = [
                "size": size
            ]
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: parameter)
        }
    }
    
    var path: String {
        switch self {
        case .yourLocationUsers:
            return "/users"
        case .globalUsers:
            return "/users"
        case .friends:
            return "/users"
        }
    }
    var method: HTTPMethod { .get }
    var header: [String: String]? { [ "Content-Type": "application/json;charset=utf-8" ] }
}
