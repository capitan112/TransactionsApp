import Foundation
import UIKit

class TransactionsViewModel: TransactionsViewModelType {
    var transactions: Bindable<[Transaction]?> = Bindable(nil)
    private var networkAPI = NetworkDataFetcher()
    private var transactionsURL = "http://www.mocky.io/v2/5b36325b340000f60cf88903"

    func fetchTransactions() {
        networkAPI.fetchTransactions(by: transactionsURL, completion: { root in
            self.transactions.value = root?.transactions
        })
    }
}
