import Foundation

public protocol NetworkSession {
    var scheme: String { get }
    var baseUrl: String { get }
    var method: NetworkMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String]? { get }
    var body: [String: Any]? { get }
    var timeout: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

public extension NetworkSession {
    var scheme: String { return "https" }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    var queryItems: [URLQueryItem] {
        return []
    }

    var method: NetworkMethod {
        return .get
    }

    var baseUrl: String {
        return "api.mercadolibre.com"
    }

    var body: [String: Any]? {
        return nil
    }
    var timeout: TimeInterval {
        return 15.0
    }
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }

    func execute<Response: Decodable>(completion: @escaping (Result<Response, NetworkError>) -> Void) {
        if ReachabilityManager.shared.connection == .unavailable {
            completion(.failure(NetworkError.notConnected))
            return
        }

        var components = URLComponents()
        components.scheme = scheme
        components.host = baseUrl
        components.path = "/" + path
        components.queryItems = queryItems

        guard let url = components.url else {
            self.completionHelper(result: .failure(NetworkError.wrongBaseUrl), completion: completion)
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeout)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.headers

        if let body = self.body,
            let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            urlRequest.httpBody = httpBody
        }

        NetworkLogger.log(request: urlRequest)

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error -> Void in
            NetworkLogger.log(response: response as? HTTPURLResponse, data: data, error: error)

            if error != nil {
                self.completionHelper(result: .failure(NetworkError.default), completion: completion)
                return
            }

            guard let data = data, let result = try? JSONDecoder().decode(Response.self, from: data) else {
                self.completionHelper(result: .failure(NetworkError.failedToDecode), completion: completion)
                return
            }
            self.completionHelper(result: .success(result), completion: completion)
        }
        task.resume()
    }
}

private extension NetworkSession {
    /// It's a helper for send response on main thread
    func completionHelper<Response: Decodable>(result: (Result<Response, NetworkError>), completion: @escaping (Result<Response, NetworkError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
