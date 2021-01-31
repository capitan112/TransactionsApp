import XCTest
@testable import Transactions

class TransactionsViewModelCellTests: XCTestCase {

    var subject: MockTransactionViewModelCell!
    override func setUpWithError() throws {
        subject = MockTransactionViewModelCell()
    }

    override func tearDownWithError() throws {
        subject = nil
        try super.tearDownWithError()
    }

    func testTransactionsViewModelCellFetchIsSuccess() throws {
        XCTAssertFalse(subject.isFetchTransactionsCalled)
        subject.fetchTransactions()
        XCTAssertTrue(subject.isFetchTransactionsCalled)
    }

}
