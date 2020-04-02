import Foundation
struct ProductsAPIResponseModel : Codable {
	let categories : [CategoriesResponseModel]?
	let rankings : [RankingsResponseModel]?

	enum CodingKeys: String, CodingKey {

		case categories = "categories"
		case rankings = "rankings"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		categories = try values.decodeIfPresent([CategoriesResponseModel].self, forKey: .categories)
		rankings = try values.decodeIfPresent([RankingsResponseModel].self, forKey: .rankings)
	}

}
