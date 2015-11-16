//
//  Project.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 9.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

struct Project {

    var id:    String?
    var name:  String?
    var managerid: String?
    var fname: String?
    var lname: String?
    var image: String?

    init(id:   String?,
        name:  String?,
        managerid: String?,
        fname: String?,
        lname: String?,
        image: String?)
    {
        self.id = id
        self.name = name
        self.managerid = managerid
        self.fname = fname
        self.lname = lname
        self.image = image
    }
}
