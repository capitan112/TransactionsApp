import Foundation

struct Transaction: Decodable, Equatable {
    let id: String
    let description: String
    let category: String
    let price: Double
    let currencyISO: String
    let iconURL: String

    enum CodingKeys: String, CodingKey {
        case id, description, category, amount, product
        case price = "value"
        case currencyISO = "currency_iso"
        case iconURL = "icon"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        category = try container.decode(String.self, forKey: .category)
        let amount = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .amount)
        price = try amount.decode(Double.self, forKey: .price)
        currencyISO = try amount.decode(String.self, forKey: .currencyISO)
        let product = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .product)
        iconURL = try product.decode(String.self, forKey: .iconURL)
    }
}

func == (lhs: Transaction, rhs: Transaction) -> Bool {
    return lhs.id == rhs.id
        && lhs.description == rhs.description
        && lhs.category == rhs.category
        && lhs.price == rhs.price
        && lhs.currencyISO == rhs.currencyISO
        && lhs.iconURL == rhs.iconURL
}
