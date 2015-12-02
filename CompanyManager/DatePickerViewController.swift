//
//  DatePickerViewController.swift
//  CompanyManager
//
//  Created by Samuli Tamminen on 30.11.2015.
//  Copyright © 2015 Samuli Tamminen. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var picker: UIDatePicker!

    var dateString: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "Y-MM-dd"

        if (dateString != "") {
            picker.date = dateFormatter.dateFromString(dateString)!
        } else {
            picker.date = NSDate()
            dateString = dateFormatter.stringFromDate(picker.date)
        }

        picker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()

        dateFormatter.dateFormat = "Y-MM-dd"

        dateString = dateFormatter.stringFromDate(datePicker.date)
        // print(dateString)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
