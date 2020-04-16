//
//  Activities.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/16.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

struct ActivitiesResponse: Codable {
    var response: [Activities]
}

struct Activities: Codable {
    var targetName: String
    var author: String
    var action: String
    var departure: Int?
    var arrival: Int?
    var createdTime: String
}
