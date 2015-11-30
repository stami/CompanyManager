//
//  DepartmentsViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 30.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit
import SwiftyJSON

class DepartmentsViewController: UITableViewController {

    var departments:[Department] = []


    func loadData(refreshControl: UIRefreshControl?) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)) {

            self.departments.removeAll()

            CompanyApi.getDepartments({ (departmentsData) -> Void in
                let json = JSON(data: departmentsData)

                if let depArray = json["data"].array {
                    // print("got data from api: departments")
                    // print(depArray)

                    for dep in depArray {
                        let department = Department(
                            id:        dep["id"].string,
                            name:      dep["name"].string
                        )
                        self.departments.append(department)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView?.reloadData()

                    if refreshControl != nil {
                        refreshControl!.endRefreshing()
                    }
                })
            })
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(nil)
        self.refreshControl?.addTarget(self, action: "loadData:", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("departmentCell", forIndexPath: indexPath)

        let dep = departments[indexPath.row] as Department

        cell.textLabel!.text = dep.name

        return cell
    }



    // Pass the selected department to the DetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        if (segue.identifier == "departmentDetailSegue") {
            let controller = segue.destinationViewController as! DepartmentDetailViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let dep = departments[row]
            controller.department = dep
            controller.index = row
        }

        else if (segue.identifier == "addDepartmentSegue") {
            let controller = segue.destinationViewController as! DepartmentDetailViewController
            let dep = Department()
            controller.department = dep
            controller.index = nil
        }
    }



    @IBAction func saveToDepartmentsViewController(segue:UIStoryboardSegue) {

        print("updateToDepartmentsViewController")

        let controller = segue.sourceViewController as! DepartmentDetailViewController
        let department = controller.department!

        if let index = controller.index {
            CompanyApi.updateDepartment(department) { (success, msg) -> () in
                if success {
                    print("updateDepartment: " + msg)
                    // print(department)
                    self.departments[index] = department
                    self.tableView?.reloadData()
                } else {
                    print("updateDepartment failed!")
                }
            }
        } else {
            CompanyApi.createDepartment(department) { (success, msg) -> () in
                if success {
                    print("createDepartment: " + msg)
                    // print(department)
                    self.departments.append(department)
                    self.tableView?.reloadData()
                } else {
                    print("createDepartment failed!")
                }
            }
        }

    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {

            // Remove department from the array
            let department = departments.removeAtIndex(indexPath.row)

            // Remove table item
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            // Delete the row from the API
            CompanyApi.deleteDepartment(department) { (success, msg) -> () in
                if success {
                    print("deleteDepartment: " + msg)
                } else {
                    print("deleteDepartment failed: " + msg)

                    // Api call failed, put the department back into list
                    self.departments.insert(department, atIndex: indexPath.row)
                    self.tableView.reloadData()
                }
            }

        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
