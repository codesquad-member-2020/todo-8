//
//  ActivitiesTableViewCell.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/16.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ActivitiesCell"
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var activities: UILabel!
    @IBOutlet weak var timeRecord: UILabel!
    
    func configure(activities: String, timeRecord: String) {
        self.activities.text = activities
        self.timeRecord.text = timeRecord
    }
}
