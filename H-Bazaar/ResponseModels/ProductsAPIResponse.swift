import Foundation
struct ProductsAPIResponse : Codable {
	let categories : [Categories]?
	let rankings : [Rankings]?

	enum CodingKeys: String, CodingKey {

		case categories = "categories"
		case rankings = "rankings"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
		rankings = try values.decodeIfPresent([Rankings].self, forKey: .rankings)
	}

}
