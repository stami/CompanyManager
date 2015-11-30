//
//  EmployeesViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 5.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit
import SwiftyJSON

class EmployeesViewController: UITableViewController {

    var employees:[Employee] = []


    func loadData(refreshControl: UIRefreshControl?) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)) {

            self.employees.removeAll()

            CompanyApi.getEmployees({ (employeesData) -> Void in
                let json = JSON(data: employeesData)

                if let empArray = json["data"].array {
                    // print(empArray)

                    for employee in empArray {
                        let emp = Employee(
                            id:     employee["id"].string,
                            fname:  employee["fname"].string,
                            lname:  employee["lname"].string,
                            salary: employee["salary"].string,
                            bdate:  employee["bdate"].string,
                            email:  employee["email"].string,
                            dep:    employee["dep"].string,
                            dname:  employee["dname"].string,
                            phone1: employee["phone1"].string,
                            phone2: employee["phone2"].string,
                            image:  employee["image"].string
                        )
                        self.employees.append(emp)
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
        return employees.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("EmployeeCell", forIndexPath: indexPath) as! EmployeeCell

            let employee = employees[indexPath.row] as Employee
            cell.employee = employee

            return cell
    }

    // Pass the selected employee to the EmployeeDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        if (segue.identifier == "detailSegue") {
            let controller = segue.destinationViewController as! EmployeeDetailViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let employee = employees[row]
            controller.employee = employee
            controller.index = row
        }

        else if (segue.identifier == "addEmployeeSegue") {
            let controller = segue.destinationViewController as! EmployeeDetailViewController
            let employee = Employee()
            controller.employee = employee
            controller.index = nil
        }


    }



    @IBAction func saveToEmployeesViewController(segue:UIStoryboardSegue) {

        let controller = segue.sourceViewController as! EmployeeDetailViewController
        let employee = controller.employee!

        if let index = controller.index {
            // print("update employee:")
            // print(employee)

            CompanyApi.updateEmployee(employee) { (success, msg) -> () in
                if success {
                    print("updateEmployee: " + msg)
                    self.employees[index] = employee
                    self.tableView?.reloadData()
                } else {
                    print("updateEmployee failed: " + msg)
                }
            }
        } else {
            // no index set, create new Employee
            // print("create employee:")
            // print(employee)

            CompanyApi.createEmployee(employee) { (success, msg) -> () in
                if success {
                    print("createEmployee: " + msg)
                    self.employees.append(employee)
                    self.tableView?.reloadData()
                } else {
                    print("createEmployee failed: " + msg)
                }
            }
        }
        
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            // Remove department from the array
            let employee = employees.removeAtIndex(indexPath.row)

            // Remove table item
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            // Delete the row from the API
            CompanyApi.deleteEmployee(employee) { (success, msg) -> () in
                if success {
                    print("deleteEmployee: " + msg)
                } else {
                    print("deleteEmployee failed: " + msg)

                    // Api call failed, put the item back into list
                    self.employees.insert(employee, atIndex: indexPath.row)
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
