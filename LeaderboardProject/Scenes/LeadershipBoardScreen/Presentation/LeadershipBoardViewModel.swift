import UIKit

protocol LeadershipBoardViewModelProtocol: AnyObject {
    func setNewSegmentController(_ controller: UIViewController)
}

class LeadershipBoardViewModel {
    enum Segment: String, CaseIterable {
        case friends = "Friends"
        case yourLocation = "Your location"
        case global = "Global"
        
        var controller: UIViewController {
            switch self {
            case .friends:
                return FriendsBoardViewController()
            case .yourLocation:
                return YourLocationBoardViewController()
            case .global:
                return GlobalBoardViewController()
            }
        }
    }
    
    var segmentTitles: [String] {
        Segment.allCases.map { $0.rawValue }
    }
    var activeSegmentIndex = 1
    
    weak var delegate: LeadershipBoardViewModelProtocol?
    
    func setNewSegment(_ index: Int) {
        activeSegmentIndex = index
        delegate?.setNewSegmentController(Segment.allCases[index].controller)
    }
    
    func viewDidLoad() {
        setNewSegment(activeSegmentIndex)
    }
}
