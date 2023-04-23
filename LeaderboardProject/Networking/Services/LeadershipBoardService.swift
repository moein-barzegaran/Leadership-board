import Foundation

protocol LeadershipBoardServicable {
    func getFriendsList(size: Int) async -> Result<[User], RequestError>
    func getYourLocationUsers(size: Int) async -> Result<[User], RequestError>
    func getGlobalUsers(size: Int) async -> Result<[User], RequestError>
}

struct LeadershipBoardService: LeadershipBoardServicable {
    
    private var client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getFriendsList(size: Int) async -> Result<[User], RequestError> {
        await client.sendRequest(
            endpoint: LeadershipBoardEndpoint.friends(size: size),
            responseModel: [User].self
        )
    }
    
    func getYourLocationUsers(size: Int) async -> Result<[User], RequestError> {
        await client.sendRequest(
            endpoint: LeadershipBoardEndpoint.yourLocationUsers(size: size),
            responseModel: [User].self
        )
    }
    
    func getGlobalUsers(size: Int) async -> Result<[User], RequestError> {
        await client.sendRequest(
            endpoint: LeadershipBoardEndpoint.globalUsers(size: size),
            responseModel: [User].self
        )
    }
}

