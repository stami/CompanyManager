//
//  CompanyApi.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 9.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import Foundation

let baseUrl = "https://home.tamk.fi/~poypek/iosapi/index.php"

class CompanyApi {


    static func getEmployees(success: ((employeesData: NSData!) -> Void)) {

        get("/employees", completion: { (data, error) -> Void in
            if let urlData = data {
                //print("getEmployees")
                //print(data);
                success(employeesData: urlData)
            }
        });

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

}