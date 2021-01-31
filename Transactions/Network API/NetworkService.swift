import Foundation

protocol NetworkProtocol {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: NetworkProtocol {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "URL string error", code: -1, userInfo: nil))
            return
        }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                completion(nil, error)
                return
            }
            
            completion(data, nil)
        })
    }
}
