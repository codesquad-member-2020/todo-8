//
//  NetworkManager.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/08.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class NetworkManager {
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    static let session = URLSession.shared
    static let serverUrl = "https://6ec56bee-8e56-4fa0-9d11-6e4240ebd3d7.mock.pstmn.io/"
    
    static func httpRequest(url: String, method: HTTPMethod, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        session.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}