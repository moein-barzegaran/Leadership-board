import Foundation

protocol LeadershipBoardServicable {
    func getFriendsList(size: Int) async -> Result<[User], RequestError>
    func getYourLocationUsers(size: Int) async -> Result<[User], RequestError>
    func getGlobalUsers(size: Int) async -> Result<[User], RequestError>
}

struct LeadershipBoardService: HTTPClient, LeadershipBoardServicable {
    func getFriendsList(size: Int) async -> Result<[User], RequestError> {
        await sendRequest(
            endpoint: LeadershipBoardEndpoint.friends(size: size),
            responseModel: [User].self
        )
    }
    
    func getYourLocationUsers(size: Int) async -> Result<[User], RequestError> {
        await sendRequest(
            endpoint: LeadershipBoardEndpoint.yourLocationUsers(size: size),
            responseModel: [User].self
        )
    }
    
    func getGlobalUsers(size: Int) async -> Result<[User], RequestError> {
        await sendRequest(
            endpoint: LeadershipBoardEndpoint.globalUsers(size: size),
            responseModel: [User].self
        )
    }
}

