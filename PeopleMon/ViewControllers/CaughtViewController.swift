//
//  CaughtViewController.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/9/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit

class CaughtViewController: UITableViewController {
    
    var caught: [People] = [ ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let people = People()
        WebServices.shared.getObjects(people) { (objects, error) in
            if let objects = objects {
                self.caught = objects
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Stuff
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caught.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PeopleCell.self)) as! PeopleCell
        
        let people = caught[indexPath.row]
        cell.setupCell(people: people)
        
        return cell
    }
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
