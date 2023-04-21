import UIKit

class LeadershipBoardComposer {
    private static func compose(viewModel: LeadershipBoardViewModel) -> LeadershipBoardViewController {
        .init(viewModel: viewModel)
    }
    
    static func makeInstance() -> LeadershipBoardViewController {
        let viewModel = LeadershipBoardViewModel()
        return compose(viewModel: viewModel)
    }
}
