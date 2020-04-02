
import Foundation
struct RankingsResponseModel : Codable {
	let ranking : String?
	let products : [ProductViewsResponseModel]?

	enum CodingKeys: String, CodingKey {

		case ranking = "ranking"
		case products = "products"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		ranking = try values.decodeIfPresent(String.self, forKey: .ranking)
		products = try values.decodeIfPresent([ProductViewsResponseModel].self, forKey: .products)
	}

}
