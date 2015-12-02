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
    @IBOutlet weak var placeholderImageView: UIImageView!

    var project: Project! {
        didSet {
            titleLabel.text = project.name!
            subLabel.text = project.fname! + " " + project.lname!

            if let imgurl = project.image {
                let imageUrl = NSURL(string: "https://home.tamk.fi/~poypek/iosapi30/" + imgurl)

                if let image = imageUrl!.cachedImage {
                    // Cached: set immediately.
                    avatarImageView.image = image
                    avatarImageView.alpha = 1
                    placeholderImageView.alpha = 0
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
            } else {
                // no image
                self.avatarImageView.alpha = 0
                self.placeholderImageView.alpha = 1
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
