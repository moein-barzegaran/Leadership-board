import Foundation

struct User: Codable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let avatar: String
    
    init(id: Int, firstName: String, lastName: String, username: String, avatar: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.avatar = avatar
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case avatar
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
        && lhs.firstName == rhs.firstName
        && lhs.lastName == rhs.lastName
        && lhs.username == rhs.username
        && lhs.avatar == rhs.avatar
    }
}
