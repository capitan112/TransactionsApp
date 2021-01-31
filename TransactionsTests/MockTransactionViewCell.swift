import Foundation
@testable import Transactions

class MockTransactionViewModelCell: TransactionsViewModelType {
    var transactions: Bindable<[Transaction]?> = Bindable(nil)
    
    var isFetchTransactionsCalled = false
    func fetchTransactions() {
        isFetchTransactionsCalled = true
    }
}
