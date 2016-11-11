
//
//  PeopleTableViewCell.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/10/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var people: People!
    
    func setupCell(people: People) {
        self.people = people
        
        nameLabel.text = people.userName
}
}
