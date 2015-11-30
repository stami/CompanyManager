//
//  CompanyApi.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 9.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import Foundation

let baseUrl = "https://home.tamk.fi/~poypek/iosapi30/index.php"

class CompanyApi {

    static func getEmployees(success: ((employeesData: NSData!) -> Void)) {
        get("/employees", completion: { (data, error) -> Void in
            if let urlData = data {
                //print("getEmployees")
                //print(data);
                success(employeesData: urlData)
            }
        })
    }

    static func deleteEmployee(emp: Employee, completion: (success: Bool, msg: String) -> ()) {
        let params = [
            "id": emp.id!
        ]
        post("/deleteEmployee", params: params, completion: { (success, msg) -> () in
            completion(success: success, msg: msg)
        })
    }

    static func updateEmployee(emp: Employee, completion: (success: Bool, msg: String) -> ()) {
        let params = [
            "id": emp.id!,
            "fname": emp.fname!,
            "lname": emp.lname!,
            "salary": emp.salary!,
            "bdate": emp.bdate!,
            "email": emp.email!,
            "dep": emp.dep!,
            "dname": emp.dname!,
            "phone1": emp.phone1!,
            "phone2": emp.phone2!,
            "image": emp.image!
        ]
        post("/updateEmployee", params: params, completion: { (success, msg) -> () in
            completion(success: success, msg: msg)
        })
    }

    static func createEmployee(emp: Employee, completion: (success: Bool, msg: String) -> ()) {
        let params = [
            "id": emp.id!,
            "fname": emp.fname!,
            "lname": emp.lname!,
            "salary": emp.salary!,
            "bdate": emp.bdate!,
            "email": emp.email!,
            "dep": emp.dep!,
            "dname": emp.dname!,
            "phone1": emp.phone1!,
            "phone2": emp.phone2!,
            "image": emp.image!
        ]
        post("/createEmployee", params: params, completion: { (success, msg) -> () in
            completion(success: success, msg: msg)
        })
    }




    static func getProjects(success: ((projectsData: NSData!) -> Void)) {
        get("/projects", completion: { (data, error) -> Void in
            if let urlData = data {
                print(data);
                success(projectsData: urlData)
            }
        });
    }



    static func getDepartments(success: ((departmentsData: NSData!) -> Void)) {
        get("/departments", completion: { (data, error) -> Void in
            if let urlData = data {
                print(data);
                success(departmentsData: urlData)
            }
        });
    }
    static func deleteDepartment(dep: Department, completion: (success: Bool, msg: String) -> ()) {
        let params = [
            "id": dep.id!
        ]
        post("/deleteDepartment", params: params, completion: { (success, msg) -> () in
            completion(success: success, msg: msg)
        })
    }
    static func updateDepartment(dep: Department, completion: (success: Bool, msg: String) -> ()) {
        let params = [
            "id": dep.id!,
            "name": dep.name!
        ]
        post("/updateDepartment", params: params, completion: { (success, msg) -> () in
            completion(success: success, msg: msg)
        })
    }
    static func createDepartment(dep: Department, completion: (success: Bool, msg: String) -> ()) {
        let params = [
            "id": dep.id!,
            "name": dep.name!
        ]
        post("/createDepartment", params: params, completion: { (success, msg) -> () in
            completion(success: success, msg: msg)
        })
    }



    static func get(path: String, completion: (data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()

        let url = NSURL(string: baseUrl + path)

        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in

            if let responseError = error {
                completion(data: nil, error: responseError)
            }
            else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain: "home.tamk.fi", code: httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })

        loadDataTask.resume()
    }

    static func post(path: String, params: Dictionary<String, String>, completion: (success: Bool, msg: String) -> ()) {
        //print("params: ", params)

        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl + path)!)

        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)
            print(request.HTTPBody)
        } catch {
            print("POST error with JSONSerialization: ", error)
        }

        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                completion(success: false, msg: "Error with task")
            }
            else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    completion(success: false, msg: "Status code not 200!")
                } else {
                    completion(success: true, msg: "Post success")
                }
            }
        }

        task.resume()
    }

}