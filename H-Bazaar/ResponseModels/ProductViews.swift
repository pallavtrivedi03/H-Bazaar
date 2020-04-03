
import Foundation
struct ProductViewsResponseModel : Codable {
	let id : Int?
    let views: Int?
    let orders: Int?
    let shares: Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case views = "view_count"
        case orders = "order_count"
        case shares = "shares"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		views = try values.decodeIfPresent(Int.self, forKey: .views)
        orders = try values.decodeIfPresent(Int.self, forKey: .orders)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
	}

}
