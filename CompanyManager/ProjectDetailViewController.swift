//
//  ProjectDetailViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 2.12.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UITableViewController {

    var project: Project?
    var index: Int?

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!

    @IBOutlet weak var manageridTextField: UITextField!
    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var lnameTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //        avatarImageView.image = UIImage(named: "Avatar")
        //
        //        let imgurl = "https://home.tamk.fi/~poypek/iosapi/" + employee!.image!
        //        let url = NSURL(string: imgurl)
        //
        //        if let data = NSData(contentsOfURL: url!) {
        //            avatarImageView.image = UIImage(data: data)!
        //        } else {
        //            // generic "no_name" image
        //            avatarImageView.image = UIImage(named: "Avatar")!
        //        }

        if let id = project?.id {
            self.idTextField.text = id
        }
        if let name = project?.name {
            self.nameTextField.text = name
        }
        if let image = project?.image {
            self.imageTextField.text = image
        }

        if let managerid = project?.managerid {
            self.manageridTextField.text = managerid
        }
        if let fname = project?.fname {
            self.fnameTextField.text = fname
        }
        if let lname = project?.lname {
            self.lnameTextField.text = lname
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "saveUnwindSegue" {
            project?.id = self.idTextField.text
            project?.name = self.nameTextField.text
            project?.image = self.imageTextField.text

            project?.managerid = self.manageridTextField.text
            project?.fname = self.fnameTextField.text
            project?.lname = self.lnameTextField.text

            print("prepare for saveUnwindSegue")
            print(project)
        }

    }

    @IBAction func setDepartmentToEmployeeDetailViewController(segue:UIStoryboardSegue) {

        let controller = segue.sourceViewController as! DepartmentPickerViewController
        let department = controller.selected_dep!

        print(department)
//
//        self.dname.text = department.name
//        employee?.dname = department.name
//        employee?.dep = department.id
    }

    @IBAction func setDateEmployeeDetailViewController(segue:UIStoryboardSegue) {
//
//        let controller = segue.sourceViewController as! DatePickerViewController
//        let dateString = controller.dateString
//        
//        print(dateString)
//        self.bdate.text = dateString
//        employee?.bdate = dateString
    }
    
    @IBAction func cancelToEmployeeDetailViewController(segue:UIStoryboardSegue) { }
    
    


}
