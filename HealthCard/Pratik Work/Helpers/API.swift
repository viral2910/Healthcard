//
//  API.swift
//  Level
//
//  Created by Pratik on 21/12/21.
//

import Foundation

protocol API {
    var baseURL: URL { get }
    var path: String { get }
    var fullURL: URL { get }
    var method: String { get }
    var params: String { get }
    var headers: [String : String]? { get }
}
extension API {
    var fullURL: URL {
        let url = URL(string: self.baseURL.absoluteString + path)!
        return url
                
    }
}
