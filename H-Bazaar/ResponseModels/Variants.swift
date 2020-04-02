
import Foundation
struct VariantsResponseModel : Codable {
	let id : Int?
	let color : String?
	let size : Int?
	let price : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case color = "color"
		case size = "size"
		case price = "price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		size = try values.decodeIfPresent(Int.self, forKey: .size)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
	}

}
