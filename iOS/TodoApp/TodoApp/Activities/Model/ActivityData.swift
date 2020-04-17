//
//  ActivityData.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/17.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import Foundation

class ActivityData {
    enum Action: String {
        case added, updated, moved, deleted
    }
    var data: Activities
    
    var activities: String? {
        didSet {
            self.dataDidChange?(self)
        }
    }
    var timeRecord: String? {
        didSet {
            self.dataDidChange?(self)
        }
    }
    
    var author: String
    var title: String
    
    var dataDidChange: ((ActivityData) -> ())?
    
    init(activity: Activities) {
        self.data = activity
        self.author = data.author
        self.title = data.targetName
        updateActivities()
        updateTimeRecord()
    }
    
    func updateActivities() {
        guard let action = Action.init(rawValue: data.action) else { return }
        switch action {
        case .added:
            self.activities = "@\(data.author) \(action.rawValue) \(data.targetName) to \(getColumnName(data.arrival))"
        case .updated:
            self.activities = "@\(data.author) \(action.rawValue) \(data.targetName) from \(getColumnName(data.arrival))"
        case .moved:
            self.activities = "@\(data.author) \(action.rawValue) \(data.targetName) from \(getColumnName(data.departure)) to \(getColumnName(data.arrival))"
        case .deleted:
            self.activities = "@\(data.author) \(action.rawValue) \(data.targetName) from \(getColumnName(data.arrival))"
        }
    }
    
    func getColumnName(_ columnId: Int?) -> String {
        guard let columnId = columnId else { return "" }
        let columnName = [1: "할일",
                          2: "하는중",
                          3: "다했음"]
        return columnName[columnId] ?? ""
    }
    
    func updateTimeRecord() {
        let time = data.createdTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let createdTime = dateFormatter.date(from: time)
        timeRecord = createdTime?.timeAgo()
    }
}

extension Date {
    func timeAgo() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        return String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current) + " ago"
    }
}
