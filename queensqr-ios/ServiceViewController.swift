//
//  ServiceViewController.swift
//  queensqr-ios
//
//  Created by Ethan Peterson on 2019-02-18.
//  Copyright © 2019 Ethan Peterson. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var genInfo: UIView!
    @IBOutlet weak var hoursView: UIView!
    
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var facultyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    @IBOutlet weak var saturday: UILabel!
    @IBOutlet weak var sunday: UILabel!
    
    
    var service : [String : Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Filter Data and Update Views and Labels
        self.navigationItem.title = "\(service["name"] as! String)"
        roomNumber.text = "Room Number: \(service["room_number"] as! String)"
        facultyLabel.text = "Faculty: \(service["faculty"] as! String)"
        descriptionLabel.text = "Description: \(service["description"] as! String)"
        
        // Update Hours
        let hoursDict = service["hours"] as! [String : String]
        monday.text = "Monday: \(hoursDict["mon"] as! String)"
        tuesday.text = "Tuesday: \(hoursDict["tue"] as! String)"
        wednesday.text = "Wednesday: \(hoursDict["wed"] as! String)"
        thursday.text = "Thursday: \(hoursDict["thu"] as! String)"
        friday.text = "Friday: \(hoursDict["fri"] as! String)"
        saturday.text = "Saturday: \(hoursDict["sat"] as! String)"
        sunday.text = "Sunday: \(hoursDict["sun"] as! String)"
        genInfo.layer.cornerRadius = 15
        hoursView.layer.cornerRadius = 15
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
