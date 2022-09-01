//
//  NetworkManager.swift
//  Navigation
//
//  Created by M M on 8/28/22.
//

import Foundation

struct NetworkResponse {
    var httpStatusCode: Int?
    var httpStatusDescription: String?
    var httpHeadersDescription: String?
    var data: String?
}

struct NetworkError: Error {
    var description: String?
}

struct NetworkManager {
    static func request(for configuration: AppConfiguration) {

        switch configuration {
        case .people(let urlString), .starships(let urlString), .planets(let urlString):

            if let url = URL(string: urlString) {
                request(url: url) { result in
                    print("---")

                    switch result {
                    case .success(let response):
                        print("request to \(urlString): SUCCESS ->")
                        if let code = response.httpResponseCode { print(" - code: \(code)") }
                        if let description = response.httpResponseDescription { print(" - description: \(description)") }
                        if let headers = response.httpHeadersDescription { print(" - headers: \(headers)")}
                        if let data = response.data { print(" - data: \(data)")}
                        break;
                    case .failure(let error):
                        print("request to \(urlString): FAILURE ->")
                        if let description = error.description { print(" - description: \(description)")}
                        break;
                    }
                }
            }
            break
        }
    }

    private static func request(url: URL, completed: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return completed(.failure(NetworkError(description: error.localizedDescription)))
            }

            if let httpResponse = response as? HTTPURLResponse {
                var result = NetworkResponse()
                result.httpStatusCode = httpResponse.statusCode
                result.httpStatusDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                result.httpHeadersDescription = httpResponse.allHeaderFields.description
                if let data = data {
                    result.data = String(data: data, encoding: .utf8)
                }
                return completed(.success(result))
            }

            return completed(.failure(NetworkError(description: "Unknown error -> \(String(describing: response))")))
        }.resume()
    }
}
