
import Foundation
struct ProductResponseModel : Codable {
	let id : Int?
	let name : String?
	let date_added : String?
	let variants : [VariantsResponseModel]?
	let tax : TaxResponseModel?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case date_added = "date_added"
		case variants = "variants"
		case tax = "tax"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		date_added = try values.decodeIfPresent(String.self, forKey: .date_added)
		variants = try values.decodeIfPresent([VariantsResponseModel].self, forKey: .variants)
		tax = try values.decodeIfPresent(TaxResponseModel.self, forKey: .tax)
	}

}
