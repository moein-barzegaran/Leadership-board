import UIKit

class YourLocationBoardComposer {
    private static func compose(viewModel: YourLocationBoardViewModel) -> YourLocationBoardViewController {
        .init(viewModel: viewModel)
    }
    
    static func makeInstance() -> YourLocationBoardViewController {
        let service = LeadershipBoardService(client: MainHTTPClient())
        let viewModel = YourLocationBoardViewModel(service: service)
        return compose(viewModel: viewModel)
    }
}
