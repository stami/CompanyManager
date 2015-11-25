//
//  EmployeeCell.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 5.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var placeholderImageView: UIImageView!

    var imageUrl: NSURL!

    var employee: Employee! {
        didSet {
            nameLabel.text = employee.fname! + " " + employee.lname!
            departmentLabel.text = employee.dname

            if let imgurl = employee.image {
                let imageUrl = NSURL(string: "https://home.tamk.fi/~poypek/iosapi/" + imgurl)

                if let image = imageUrl!.cachedImage {
                    // Cached: set immediately.
                    avatarImageView.image = image
                    avatarImageView.alpha = 1
                } else {
                    // Not cached, so load then fade it in.
                    avatarImageView.alpha = 0
                    placeholderImageView.alpha = 1
                    imageUrl!.fetchImage { image in
                        self.avatarImageView.image = image
                        UIView.animateWithDuration(0.3) {
                            self.avatarImageView.alpha = 1
                            self.placeholderImageView.alpha = 0
                        }
                    }
                }
            }
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
