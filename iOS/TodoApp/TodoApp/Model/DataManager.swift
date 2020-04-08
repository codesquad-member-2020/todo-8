//
//  DataManager.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/08.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class DataManager {
    private var data: [Column]?
    
    func loadData(completion: @escaping () -> ()) {
        let url = NetworkManager.serverUrl
        NetworkManager.getRequest(url: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(TodoData.self, from: data)
                self.data = decodedData.columns
                completion()
            } catch {
                
            }
        }
    }
    
    func data(of identifier: String) -> [Card] {
        guard let data = data else { return [Card]() }
        for column in data {
            if column.id == identifier {
                return column.cards
            }
        }
        return [Card]()
    }
}
