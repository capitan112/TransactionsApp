import Foundation
import UIKit

class TransactionsViewModel: TransactionsViewModelType {
    var transactions: Bindable<[Transaction]?> = Bindable(nil)
    private var networkAPI = NetworkDataFetcher()
    private var transactionsURL = "http://www.mocky.io/v2/5b36325b340000f60cf88903"
    
    func fetchTransactions() {
        networkAPI.fetchTransactions(by: transactionsURL, completion: { response in
            guard let dict = try? response.get(), let transactions = dict["data"] else {
                return
            }

            self.transactions.value = transactions
        })
    }
}
