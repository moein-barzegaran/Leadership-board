import Foundation

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case avatar
    }
}
