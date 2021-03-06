import XCTest
@testable import Transactions

class TransactionViewModelCellTest: XCTestCase {
    
    var subject: TransactionViewModelCell!
    var transaction: Transaction!
    
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        subject = nil
        try super.tearDownWithError()
    }

    func testTransactionsWithGBPPriceFormat() throws {
        let transaction = fetchTransaction(json: transactionsGBPjson)
        
        XCTAssertEqual(transaction.price, Double(13.00))
        XCTAssertEqual(transaction.currencyISO, "GBP")
        subject = TransactionViewModelCell(transaction: transaction)
        
        XCTAssertEqual(subject.price, "£13.00")
    }
    
    func testTransactionsWithEURPriceFormat() throws {
        let transaction = fetchTransaction(json: transactionsEURjson)
        XCTAssertEqual(transaction.price, Double(15.00))
        XCTAssertEqual(transaction.currencyISO, "EUR")
        subject = TransactionViewModelCell(transaction: transaction)

        XCTAssertEqual(subject.price, "€15.00")
    }
    
    private func fetchTransaction(json: String) -> Transaction {
        let jsonData = json.data(using: .utf8)!
        let transaction: Transaction = try! JSONDecoder().decode(Transaction.self, from: jsonData)
        
        return transaction
    }
}


let transactionsGBPjson = """
{
    "id": "13acb877dc4d8030c5dacbde33d3496a2ae3asdc000db4c793bda9c3228baca1a28",
    "date": "2018-03-19",
    "description": "Forbidden planet",
    "category": "General",
    "currency": "GBP",
    "amount": {
        "value": 13,
        "currency_iso": "GBP"
    },
    "product": {
        "id": 4279,
        "title": "Lloyds Bank",
        "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
    }
}
"""

let transactionsEURjson = """
{
    "id": "13acb877dc4d8030c5dacbde33d3496a2ae3asdc000db4c793bda9c3228baca1a28",
    "date": "2018-03-19",
    "description": "Forbidden planet",
    "category": "General",
    "currency": "EUR",
    "amount": {
        "value": 15,
        "currency_iso": "EUR"
    },
    "product": {
        "id": 4279,
        "title": "Lloyds Bank",
        "icon": "https://storage.googleapis.com/budcraftstorage/uploads/products/lloyds-bank/Llyods_Favicon-1_161201_091641.jpg"
    }
}
"""
