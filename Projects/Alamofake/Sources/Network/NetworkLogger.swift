//
//  NetworkLogger.swift
//  Alamofake
//
//  Created by Decio Montanhani on 25/01/21.
//

import Foundation

final class NetworkLogger {

    static func log(request: URLRequest) {
       print("- - - - - - - NETWORK REQUEST - - - - - - ")
       defer { print("- - - - - - - - - -  END - - - - - - - - - -") }
       let urlAsString = request.url?.absoluteString ?? ""
       let urlComponents = URLComponents(string: urlAsString)
       let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
       let path = "\(urlComponents?.path ?? "")"
       let query = "\(urlComponents?.query ?? "")"
       let host = "\(urlComponents?.host ?? "")"
       var output = """
       [REQUEST] \(method) \(path)?\(query) \n
       HOST: \(host)\n
       """
       for (key,value) in request.allHTTPHeaderFields ?? [:] {
          output += "\(key): \(value) \n"
       }

        #if DEBUG
       print(output)
        #endif

    }

    static func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
       print("- - - - - - - NETWORK RESPONSE - - - - - - - - ")
       defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
       let urlString = response?.url?.absoluteString
       let components = NSURLComponents(string: urlString ?? "")
       let path = "\(components?.path ?? "")"
       let query = "\(components?.query ?? "")"
       var output = ""
       if let statusCode =  response?.statusCode {
          output += "[RESPONSE] \(statusCode) \(path)?\(query)\n"
       }
       if let host = components?.host {
          output += "Host: \(host)\n"
       }

       if error != nil {
          output += "\nError: \(error!.localizedDescription)\n"
       }

        #if DEBUG
       print(output)
        #endif
    }
}
