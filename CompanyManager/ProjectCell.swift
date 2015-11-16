//
//  ProjectCell.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 9.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    var project: Project! {
        didSet {
            titleLabel.text = project.name!
            subLabel.text = project.fname! + " " + project.lname!
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
