import XCTest
@testable import LeaderboardProject

class YourLocationBoardViewModelTests: XCTestCase {
    
    var viewModel: YourLocationBoardViewModel!
    var mockService: MockLeadershipBoardService!
    
    override func setUp() {
        super.setUp()
        mockService = MockLeadershipBoardService()
        viewModel = YourLocationBoardViewModel(service: mockService)
    }
    
    func test_viewDidLoad_fetchesData() {
        let expectation = self.expectation(description: "fetch data")
        mockService.getYourLocationUsersResult = .success([User]())
        
        viewModel.delegate = self
        viewModel.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // add delay to ensure async task is finished
            XCTAssertTrue(self.mockService.getYourLocationUsersCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func test_numberOfItems_returnsCountOfUsers() {
        let expectation = self.expectation(description: "fetch data")
        let users = [User(id: 1, firstName: "name1", lastName: "lastName1", username: "username1", avatar: ""),
                     User(id: 2, firstName: "name2", lastName: "lastName2", username: "username2", avatar: "")]
        mockService.getYourLocationUsersResult = .success(users)
        
        viewModel.delegate = self
        viewModel.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // add delay to ensure async task is finished
            XCTAssertEqual(self.viewModel.numberOfItems(), 2)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}

extension YourLocationBoardViewModelTests: YourLocationBoardViewModelProtocol {
    func updateUI() {}
}

class MockLeadershipBoardService: LeadershipBoardServicable {
    var getYourLocationUsersCalled = false
    var getYourLocationUsersResult: Result<[User], RequestError>!
    
    func getYourLocationUsers(size: Int) async -> Result<[User], RequestError> {
        getYourLocationUsersCalled = true
        return getYourLocationUsersResult
    }
    
    func getFriendsList(size: Int) async -> Result<[User], RequestError> {
        fatalError("Not implemented")
    }
    
    func getGlobalUsers(size: Int) async -> Result<[User], RequestError> {
        fatalError("Not implemented")
    }
}

class MockYourLocationBoardViewModelDelegate: YourLocationBoardViewModelProtocol {
    var updateUICalled = false
    
    func updateUI() {
        updateUICalled = true
    }
}
