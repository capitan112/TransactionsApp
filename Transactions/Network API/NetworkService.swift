import Foundation

protocol NetworkProtocol {
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: NetworkProtocol {
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "URL string error", code: -1, userInfo: nil)))
            
            return
        }
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

            
            if error != nil || data == nil {
                completion(.failure(error!))
                return
            }

            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                completion(.failure(ConversionFailure.responceError))
                return
            }

            guard let data = data else {
                completion(.failure(ConversionFailure.invalidData))
                return
            }
            
            completion(.success(data))
        })
    }
}
