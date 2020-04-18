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
            data?.dataDidChange = { [unowned self] data in
                self.updateWithData()
                self.timeRecord.text = data.timeRecord
            }
        }
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var activities: UILabel!
    @IBOutlet weak var timeRecord: UILabel!
    
    func configure(activities: Activities) {
        self.data = ActivityData(activity: activities)
        data?.updateActivities()
    }
    
    func updateWithData() {
        let attributedString = NSMutableAttributedString(string: data!.activities!)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (data!.activities! as NSString).range(of: data!.author))
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (data!.activities! as NSString).range(of: data!.title))
        activities.attributedText = attributedString
    }
}
