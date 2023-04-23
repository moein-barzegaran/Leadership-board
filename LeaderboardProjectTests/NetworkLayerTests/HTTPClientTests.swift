import XCTest
@testable import LeaderboardProject

class LeadershipBoardServiceTests: XCTestCase {
    
    var httpClient: MockHTTPClient!
    var service: LeadershipBoardService!
    
    override func setUp() {
        super.setUp()
        httpClient = MockHTTPClient()
        service = LeadershipBoardService(client: httpClient)
    }
    
    override func tearDown() {
        httpClient = nil
        service = nil
        super.tearDown()
    }
    
    func testGetFriendsList_Success() async throws {
        let expectedResponse = [
            User(id: 1, firstName: "name1", lastName: "lastName1", username: "username1", avatar: ""),
            User(id: 2, firstName: "name2", lastName: "lastName2", username: "username2", avatar: "")
        ]
        let expectedResponseData = try JSONEncoder().encode(expectedResponse)
        httpClient.response = .success(expectedResponseData)
        
        let result = await service.getFriendsList(size: 10)
        
        XCTAssertTrue(httpClient.sendRequestCalled)
        XCTAssertEqual(result, .success(expectedResponse))
    }
    
    func testGetYourLocationUsers_Failure() async throws {
        httpClient.response = .failure(.noResponse)
        
        let result = await service.getYourLocationUsers(size: 10)
        
        XCTAssertTrue(httpClient.sendRequestCalled)
        XCTAssertEqual(result, .failure(.noResponse))
    }
    
    func testGetGlobalUsers_DecodeFailure() async throws {
        httpClient.response = .success("invalid response data".data(using: .utf8)!)
        
        let result = await service.getGlobalUsers(size: 10)
        
        XCTAssertTrue(httpClient.sendRequestCalled)
        XCTAssertEqual(result, .failure(.decode))
    }
}

class MockHTTPClient: HTTPClient {
    var sendRequestCalled = false
    var response: Result<Data, RequestError>!
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> Result<T, RequestError> {
        sendRequestCalled = true
        switch response {
        case .success(let data):
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedResponse)
            } catch {
                return .failure(.decode)
            }
        case .failure(let error):
            return .failure(error)
        case .none:
            fatalError("MockHTTPClient response not set")
        }
    }
}
