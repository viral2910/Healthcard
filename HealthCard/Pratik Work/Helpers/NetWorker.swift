//
//  NetWorker.swift
//  Level
//
//  Created by Pratik on 21/12/21.
//

import Foundation
import UIKit

class NetWorker {
    static var shared = NetWorker()
    
    public var showHud: () -> () = {}
    public var hideHud: () -> () = {}
        
    private func requestFromAuthType(_ api: API) -> URLRequest {
        
        let url = api.fullURL
        let method = api.method
        let params: [String: Any] = api.params
        let headers = api.headers
        let methods = api.method
        if methods == "GET" {
            
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.allHTTPHeaderFields = headers
            
            
            print("url- ", url)
            print("method- ", method)
            print("params- ", params)
            print("headers- ", headers ?? "")
            
            print("Endpoint - \(url)")
            print("Params - \(params)")
            
            return request
        } else {
        let body = (try? JSONSerialization.data(withJSONObject: params, options: [])) ?? Data()
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        
        
        print("url- ", url)
        print("method- ", method)
        print("params- ", params)
        print("headers- ", headers ?? "")
        print("body- ", body)
        
        print("Endpoint - \(url)")
        print("Params - \(params)")
        
        return request
        }
    }
    
    public func callAPIService <T: Codable> (type: API, completion: @escaping (T?, Error?) -> Void) {
        let request = requestFromAuthType(type)
        
        self.showHud()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.global().async {
                DispatchQueue.main.sync {
                    self.hideHud()
                    print("--- Entering Response ---")
                    let responseString = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    
                    print(responseString)
                    
                    if responseString.isEmpty {
                        // show error alert
                    }
                    
                    do {
                        let decodedResponse = try JSONDecoder().decode(T.self, from: data ?? Data())
                        completion(decodedResponse, nil)
                    } catch {
                        completion(nil, error)
                        print(error.localizedDescription)
                        UIAlertController.showAlert(titleString: error.localizedDescription)
                    }
                }
            }
        }.resume()
    }
    
}
