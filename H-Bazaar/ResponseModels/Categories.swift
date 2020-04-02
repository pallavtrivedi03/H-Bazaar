
import Foundation
struct Categories : Codable {
	let id : Int?
	let name : String?
	let products : [Product]?
	let childCategories : [Int]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case products = "products"
		case childCategories = "child_categories"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		products = try values.decodeIfPresent([Product].self, forKey: .products)
		childCategories = try values.decodeIfPresent([Int].self, forKey: .childCategories)
	}

}
