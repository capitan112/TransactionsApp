import Foundation

class TransactionsViewModel: TransactionsViewModelType {

    var transactions: Bindable<[Transaction]?> = Bindable(nil)
    private var networkAPI = NetworkDataFetcher()
    private var transactionsURL = "http://www.mocky.io/v2/5b36325b340000f60cf88903"
    
    func fetchTransactions() {
        networkAPI.fetchTransactions(by: transactionsURL, completion: { root in
            self.transactions.value = root?.transactions
        })
    }
        
    func currencyFormater(code: String, price: Double) -> String {
        let convertedPrice = price as NSNumber

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let locale = "en_" + code.dropLast()
        formatter.locale = Locale(identifier: locale)
        return formatter.string(from: convertedPrice) ?? ""
    }
    
    func getSymbol(forCurrencyCode code: String) -> String {
        let locale = NSLocale(localeIdentifier: code)
        print(locale)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code) ?? "£"
        }
        
        return locale.displayName(forKey: .currencySymbol, value: code) ?? "£"
    }
}


