//
//  EmployeeDetailViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 5.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UITableViewController {

    var employee: Employee?
    var index: Int?

    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var image: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var dname: UILabel!
    @IBOutlet weak var bdate: UILabel!
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var phone2: UITextField!



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

        if let id = employee?.id {
            self.id.text = id
        }
        if let image = employee?.image {
            self.image.text = image
        }
        if let fname = employee?.fname {
            self.fname.text = fname
        }
        if let lname = employee?.lname {
            self.lname.text = lname
        }
        if let salary = employee?.salary {
            self.salary.text = salary
        }
        if let email = employee?.email {
            self.email.text = email
        }
        if let dname = employee?.dname {
            self.dname.text = dname
        }
        if let bdate = employee?.bdate {
            self.bdate.text = bdate
        }
        if let phone1 = employee?.phone1 {
            self.phone1.text = phone1
        }
        if let phone2 = employee?.phone2 {
            self.phone2.text = phone2
        }



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "saveUnwindSegue" {
            employee?.id = self.id.text
            employee?.image = self.image.text
            employee?.fname = self.fname.text
            employee?.lname = self.lname.text
            employee?.salary = self.salary.text
            employee?.email = self.email.text
            //employee?.dep = self.dep.text
            employee?.bdate = self.bdate.text
            employee?.phone1 = self.phone1.text
            employee?.phone2 = self.phone2.text
            print("prepare for saveUnwindSegue")
            print(employee)
        }

        if segue.identifier == "departmentPickerSegue" {
            let destination = segue.destinationViewController as! DepartmentPickerViewController
            let dep = Department(id: employee?.dep, name: employee?.dname)
            destination.selected_dep = dep
        }

        if segue.identifier == "datePickerSegue" {
            let destination = segue.destinationViewController as! DatePickerViewController
            if let date = employee?.bdate {
                destination.dateString = date
            }

        }

    }

    @IBAction func setDepartmentToEmployeeDetailViewController(segue:UIStoryboardSegue) {

        let controller = segue.sourceViewController as! DepartmentPickerViewController
        let department = controller.selected_dep!

        print(department)

        self.dname.text = department.name
        employee?.dname = department.name
        employee?.dep = department.id
    }

    @IBAction func setDateEmployeeDetailViewController(segue:UIStoryboardSegue) {

        let controller = segue.sourceViewController as! DatePickerViewController
        let dateString = controller.dateString

        print(dateString)
        self.bdate.text = dateString
        employee?.bdate = dateString
    }

    @IBAction func cancelToEmployeeDetailViewController(segue:UIStoryboardSegue) { }



//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
//        cell.textField.becomeFirstResponder()
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
