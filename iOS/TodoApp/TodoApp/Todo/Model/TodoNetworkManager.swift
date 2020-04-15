//
//  TodoNetworkManager.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/15.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class TodoNetworkManager {
    static let decoder = JSONDecoder()
    
    static func addCardRequest(card: Card, completion: @escaping (Card?) -> ()) {
        let data = ["categoryId": "\(card.categoryId)", "author": card.author, "title": card.title, "contents": card.contents]
        let body = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        NetworkManager.httpRequest(url: NetworkManager.serverUrl + "cards", method: .POST, body: body) { (data, response, error) in
            guard let data = data else { return }
            do {
                let data = try decoder.decode(Response.self, from: data)
                completion(data.response)
            } catch {
                completion(nil)
            }
        }
    }
    
    static func deleteCardRequest(card: Card, completion: @escaping (Bool) -> ()) {
        NetworkManager.httpRequest(url: NetworkManager.serverUrl + "cards/" + "\(card.id)", method: .DELETE) { (data, response, error) in
            guard let data = data else { return }
            do {
                let data = try decoder.decode(Response.self, from: data)
                completion(data.success)
            } catch {
                completion(false)
            }
        }
    }
    
    static func editCardRequest(card: Card, completion: @escaping (Card?) -> ()) {
        let data = ["categoryId": "\(card.categoryId)", "author": card.author, "title": card.title, "contents": card.contents]
        let body = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        NetworkManager.httpRequest(url: NetworkManager.serverUrl + "cards/" + "\(card.id)", method: .PUT, body: body) { (data, response, error) in
            guard let data = data else { return }
            do {
                let data = try decoder.decode(Response.self, from: data)
                completion(data.response)
            } catch {
                completion(nil)
            }
        }
    }
    
    static func moveCardRequest(card: Card, category: Int, index: Int, completion: @escaping (Card?) -> ()) {
        NetworkManager.httpRequest(url: NetworkManager.serverUrl + "cards/" + "\(card.id)/" + "position?category=\(category)&index=\(index)", method: .PUT) { (data, response, error) in
            guard let data = data else { return }
            do {
                let data = try decoder.decode(Response.self, from: data)
                completion(data.response)
            } catch {
                completion(nil)
            }
        }
    }
}
