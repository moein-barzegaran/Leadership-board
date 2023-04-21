import XCTest
@testable import LeaderboardProject

final class LeadershipBoardViewModelTests: XCTestCase {
    
    var viewModel: LeadershipBoardViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LeadershipBoardViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSegmentTitles() {
        XCTAssertEqual(viewModel.segmentTitles, ["Friends", "Your location", "Global"])
    }
    
    func testActiveSegmentIndex() {
        viewModel.activeSegmentIndex = 0
        XCTAssertEqual(viewModel.activeSegmentIndex, 0)
        
        viewModel.activeSegmentIndex = 2
        XCTAssertEqual(viewModel.activeSegmentIndex, 2)
    }
    
    func testSetNewSegment() {
        let delegate = MockLeadershipBoardViewModelDelegate()
        viewModel.delegate = delegate
        
        viewModel.setNewSegment(0)
        XCTAssertEqual(viewModel.activeSegmentIndex, 0)
        XCTAssertTrue(delegate.didSetNewSegmentControllerCalled)
    }
    
    func testSegmentControllers() {
        let delegate = MockLeadershipBoardViewModelDelegate()
        viewModel.delegate = delegate
        
        // Test FriendsBoardViewController
        viewModel.setNewSegment(0)
        XCTAssertTrue(delegate.segmentController is FriendsBoardViewController)

        // Test YourLocationBoardViewController
        viewModel.setNewSegment(1)
        XCTAssertTrue(delegate.segmentController is YourLocationBoardViewController)
        
        // Test GlobalBoardViewController
        viewModel.setNewSegment(2)
        XCTAssertTrue(delegate.segmentController is GlobalBoardViewController)
    }
    
    
    func testViewDidLoad() {
        let delegate = MockLeadershipBoardViewModelDelegate()
        viewModel.delegate = delegate
        
        viewModel.viewDidLoad()
        XCTAssertTrue(delegate.didSetNewSegmentControllerCalled)
    }
}

class MockLeadershipBoardViewModelDelegate: LeadershipBoardViewModelProtocol {
    
    var segmentController: UIViewController?
    var didSetNewSegmentControllerCalled = false
    
    func setNewSegmentController(_ controller: UIViewController) {
        didSetNewSegmentControllerCalled = true
        segmentController = controller
    }
}
