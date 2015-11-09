//
//  Employee.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 5.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

struct Employee {
    var id: String?
    var fname: String?
    var lname: String?
    var salary: String?
    var bdate: String?
    var email: String?
    var dep: String?
    var dname: String?
    var phone1: String?
    var phone2: String?
    var image: String?

    init(id:    String?,
        fname:  String?,
        lname:  String?,
        salary: String?,
        bdate:  String?,
        email:  String?,
        dep:    String?,
        dname:  String?,
        phone1: String?,
        phone2: String?,
        image:  String?)
    {
        self.id = id
        self.fname = fname
        self.lname = lname
        self.salary = salary
        self.bdate = bdate
        self.email = email
        self.dep = dep
        self.dname = dname
        self.phone1 = phone1
        self.phone2 = phone2
        self.image = image
    }
}