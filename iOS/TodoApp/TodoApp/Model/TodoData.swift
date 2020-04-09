//
//  TodoData.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/08.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

struct TodoData: Codable {
    var columns: [Column]
}

struct Column: Codable {
    var id: String
    var title: String
    var cards: [Card]
}

struct Card: Codable, Equatable {
    var id: String
    var title: String
    var author: String
    var contents: String
    var createdDate: String
    var modifiedDate: String
}
