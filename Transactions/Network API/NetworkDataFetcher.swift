import Foundation

protocol NetworkDataFetcherProtocol {
    func fetchTransactions(by ulr: String, completion: @escaping ([String: [Transaction]]?) -> Void)
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: NetworkDataFetcherProtocol {
    var networking: NetworkProtocol

    init(networking: NetworkProtocol = NetworkService()) {
        self.networking = networking
    }

    func fetchTransactions(by ulr: String, completion: @escaping ([String: [Transaction]]?) -> Void) {
        fetchGenericJSONData(urlString: ulr, response: completion)
    }

    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void) {
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }

            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }

    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
