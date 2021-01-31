import Foundation

struct TransactionViewModelCell: TransactionViewModelCellType {
    var description: String
    var category: String
    var currencyISO: String
    private var _price: Double
    var price: String {
        currencyFormater(code: currencyISO,
                         price: _price)
    }

    var iconURL: URL?
    private var defaultPrice = "£0.00"

    init(transaction: Transaction) {
        description = transaction.description
        category = transaction.category
        currencyISO = transaction.currencyISO
        _price = transaction.price
        iconURL = URL(string: transaction.iconURL)
    }

    private func currencyFormater(code: String, price: Double) -> String {
        let convertedPrice = price as NSNumber

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let locale = "en_" + code.dropLast()
        formatter.locale = Locale(identifier: locale)

        return formatter.string(from: convertedPrice) ?? defaultPrice
    }
}
