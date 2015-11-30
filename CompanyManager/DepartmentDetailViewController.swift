//
//  DepartmentDetailViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 30.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

class DepartmentDetailViewController: UITableViewController {

    var department: Department?
    var index: Int?

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = department?.id {
            self.idTextField.text = id
        }
        if let name = department?.name {
            self.nameTextField.text = name
        }

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "saveUnwindSegue" {
            department?.id = self.idTextField.text
            department?.name = self.nameTextField.text

            print("prepare for saveUnwindSegue")
        }
    }

}
