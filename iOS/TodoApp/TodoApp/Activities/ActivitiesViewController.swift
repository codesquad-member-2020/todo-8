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
    var activities: [Activities]? {
        didSet {
            DispatchQueue.main.async {
                self.activitiesTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiesTableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        NetworkManager.httpRequest(url: NetworkManager.serverUrl + "activities", method: .GET) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(ActivitiesResponse.self, from: data)
                self.activities = data.response
            } catch {
                
            }
        }
    }
}

extension ActivitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivitiesTableViewCell.reuseIdentifier) as? ActivitiesTableViewCell,
            let activities = activities else {
                return ActivitiesTableViewCell()
        }
        cell.configure(activities: activities[indexPath.row].targetName, timeRecord: activities[indexPath.row].createdTime)
        return cell
    }
}
