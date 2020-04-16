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
    
    private var data: ActivityData? {
        didSet {
            activities.text = data?.activities
            timeRecord.text = data?.timeRecord
        }
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var activities: UILabel!
    @IBOutlet weak var timeRecord: UILabel!
    
    func configure(activities: Activities) {
        self.data = ActivityData(activity: activities)
    }
}
