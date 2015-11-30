//
//  DepartmentPickerViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 30.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit
import SwiftyJSON

class DepartmentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var departmentPicker: UIPickerView!

    var departments:[Department] = []
    var selected_dep: Department?

    func loadData() {
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
                    self.departmentPicker.reloadAllComponents()

                    if let dep = self.selected_dep {
                        if (dep.id != "") {
                            // Select the given department
                            for (var i = 0; i < self.departments.count; i++) {
                                if (dep.id == self.departments[i].id) {
                                    self.departmentPicker.selectRow(i, inComponent: 0, animated: false)
                                    break
                                }
                            }
                        } else {
                            // Select the first
                            self.selected_dep = self.departments[0]
                            print("selected dep")
                            print(self.selected_dep)
                            self.departmentPicker.selectRow(0, inComponent: 0, animated: false)
                        }
                    }
                })
            })
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()

        // Connect data:
        self.departmentPicker.delegate = self
        self.departmentPicker.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments.count
    }

    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departments[row].name
    }

    // Capture the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.

        selected_dep = departments[row]
        print("selected: \(selected_dep)")
    }

}
