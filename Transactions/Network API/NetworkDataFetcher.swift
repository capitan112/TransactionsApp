import Foundation

enum ConversionFailure: Error {
    case invalidData
    case missingData
    case responceError
}

protocol NetworkDataFetcherProtocol {    
    func fetchTransactions(by ulr: String, completion: @escaping (Result<[String: [Transaction]], Error>) -> Void)
    func fetchGenericJSONData(urlString: String, response: @escaping (Result<[String: [Transaction]], Error>) -> Void)
}

class NetworkDataFetcher: NetworkDataFetcherProtocol {
    var networking: NetworkProtocol

    init(networking: NetworkProtocol = NetworkService()) {
        self.networking = networking
    }

    func fetchTransactions(by ulr: String, completion: @escaping (Result<[String: [Transaction]], Error>) -> Void) {
        fetchGenericJSONData(urlString: ulr, response: completion)
    }

    func fetchGenericJSONData(urlString: String, response: @escaping (Result<[String: [Transaction]], Error>) -> Void) {
        networking.request(urlString: urlString) { dataResponse in
            guard let data = try? dataResponse.get() else {
                response(.failure(ConversionFailure.responceError))
                return
            }

            self.decodeJSON(from: data, completion: response)
        }
    }

    private func decodeJSON(from data: Data?, completion: @escaping (Result<[String: [Transaction]], Error>) -> Void) {
        guard let data = data else {
            completion(.failure(ConversionFailure.missingData))
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let result = Result(catching: {
                try decoder.decode([String: [Transaction]].self, from: data)
            })
            
            completion(result)
        }
    }
}
