//
//  ActivitiesViewController.swift
//  TodoApp
//
//  Created by TTOzzi on 2020/04/16.
//  Copyright © 2020 TTOzzi. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    @IBOutlet weak var activitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiesTableView.dataSource = self
    }
}

extension ActivitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivitiesTableViewCell.reuseIdentifier) as? ActivitiesTableViewCell else {
            return ActivitiesTableViewCell()
        }
        cell.configure(activities: "테스트", timeRecord: "test")
        return cell
    }
}
