
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
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var people: People!
    
    func setupCell(people: People) {
        self.people = people
        
        nameLabel.text = people.userName
         if let createdDate = people.created {
            let date = Date(fromString: createdDate, format: .iso8601(nil))
            dateLabel.text = date.toString(.custom("M/d/yyyy h:m:s a"))
        }
        
        if let image = Utils.imageFromString(imageString: people.avatarBase64) {
            pictureView.image = image
        } else {
            pictureView.image = Images.Avatar.image()
        }
    }
}
