//
//  Employee.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 5.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

struct Employee {
    var id: Int?
    var fname: String?
    var lname: String?
    var salary: String?
    var bdate: String?
    var email: String?
    var phone1: String?


    init(id: Int?, fname: String?, lname: String?, salary: String?, bdate: String, email: String?, phone1: String?) {
        self.id = id
        self.fname = fname
        self.lname = lname
        self.salary = salary
        self.bdate = bdate
        self.email = email
        self.phone1 = phone1
    }
}