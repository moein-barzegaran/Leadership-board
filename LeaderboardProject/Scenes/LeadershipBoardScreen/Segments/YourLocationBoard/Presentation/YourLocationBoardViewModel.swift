import Foundation

protocol YourLocationBoardViewModelProtocol: AnyObject {
    func updateUI()
}

class YourLocationBoardViewModel {
    
    private let service: LeadershipBoardServicable
    private var users: [User]?
    
    weak var delegate: YourLocationBoardViewModelProtocol?
    
    init(service: LeadershipBoardServicable) {
        self.service = service
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func numberOfItems() -> Int {
        users?.count ?? 0
    }
    
    func getItem(at index: Int) -> User? {
        users?[index]
    }
    
    private func fetchData() {
        Task(priority: .background) {
            let result = await service.getYourLocationUsers(size: 20)
            switch result {
            case let .success(users):
                self.users = users
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
            case .failure:
                print("Handle error")
            }
        }
    }
}
