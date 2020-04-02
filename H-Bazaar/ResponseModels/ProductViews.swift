
import Foundation
struct ProductViewsResponseModel : Codable {
	let id : Int?
    let viewCount: Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case viewCount = "view_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		viewCount = try values.decodeIfPresent(Int.self, forKey: .viewCount)
	}

}
