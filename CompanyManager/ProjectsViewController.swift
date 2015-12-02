//
//  ProjectsViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 16.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProjectsViewController: UITableViewController {

    var projects:[Project] = []


    func loadData(refreshControl: UIRefreshControl?) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)) {

            self.projects.removeAll()

            CompanyApi.getProjects({ (projectsData) -> Void in
                let json = JSON(data: projectsData)

                if let projArray = json["data"].array {
                    // print(projArray)

                    for project in projArray {
                        let proj = Project(
                            id:        project["id"].string,
                            name:      project["name"].string,
                            managerid: project["managerid"].string,
                            fname:     project["fname"].string,
                            lname:     project["lname"].string,
                            image:     project["image"].string
                        )
                        self.projects.append(proj)
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
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProjectCell", forIndexPath: indexPath) as! ProjectCell

            let project = projects[indexPath.row] as Project
            cell.project = project
            
            return cell
    }


    // Pass the selected employee to the EmployeeDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        if (segue.identifier == "detailSegue") {
            let controller = segue.destinationViewController as! ProjectDetailViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            let project = projects[row]
            controller.project = project
            controller.index = row
        }

        else if (segue.identifier == "addProjectSegue") {
            let controller = segue.destinationViewController as! ProjectDetailViewController
            let project = Project()
            controller.project = project
            controller.index = nil
        }
        
    }


    @IBAction func saveToProjectsViewController(segue:UIStoryboardSegue) {

        let controller = segue.sourceViewController as! ProjectDetailViewController
        let project = controller.project!

        if let index = controller.index {
            // print("update employee:")
            // print(employee)

            CompanyApi.updateProject(project) { (success, msg) -> () in
                if success {
                    print("updateProject: " + msg)
                    self.projects[index] = project
                    self.tableView?.reloadData()
                } else {
                    print("updateProject failed: " + msg)
                }
            }
        } else {
            // no index set, create new Employee
            // print("create employee:")
            // print(employee)

            CompanyApi.createProject(project) { (success, msg) -> () in
                if success {
                    print("createProject: " + msg)
                    self.projects.append(project)
                    self.tableView?.reloadData()
                } else {
                    print("createProject failed: " + msg)
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
            let project = projects.removeAtIndex(indexPath.row)

            // Remove table item
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            // Delete the row from the API
            CompanyApi.deleteProject(project) { (success, msg) -> () in
                if success {
                    print("deleteProject: " + msg)
                } else {
                    print("deleteProject failed: " + msg)

                    // Api call failed, put the item back into list
                    self.projects.insert(project, atIndex: indexPath.row)
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
