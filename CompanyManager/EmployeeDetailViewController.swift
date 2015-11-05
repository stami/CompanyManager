//
//  EmployeeDetailViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 5.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

    var employee: Employee?

    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var bdateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        avatarImageView.image = UIImage(named: "Avatar")

        if let fname = employee?.fname {
            if let lname = employee?.lname {
                fullNameLabel.text = fname + " " + lname
            }
        }
        if let bdate = employee?.bdate {
            bdateLabel.text = bdate
        }
        if let email = employee?.email {
            emailLabel.text = email
        }
        if let salary = employee?.salary {
            salaryLabel.text = salary
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelToEmployeeDetailViewController(segue:UIStoryboardSegue) {
    }

    @IBAction func saveEmployeeDetail(segue:UIStoryboardSegue) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
