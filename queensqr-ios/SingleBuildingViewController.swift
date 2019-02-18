//
//  SingleBuildingViewController.swift
//  queensqr-ios
//
//  Created by Ethan Peterson on 2019-02-18.
//  Copyright © 2019 Ethan Peterson. All rights reserved.
//

import UIKit
import Alamofire

class SingleBuildingViewController: UIViewController {
    // View and Button Outlets
    @IBOutlet weak var servicesButton: UIButton!
    @IBOutlet weak var genInfo: UIView!
    @IBOutlet weak var hoursView: UIView!
    
    
    // Label Outlets
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var facultyLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    @IBOutlet weak var saturday: UILabel!
    @IBOutlet weak var sunday: UILabel!
    
    
    
    var qrData : String = ""
    var apiRoot = ProcessInfo.processInfo.environment["API_ROOT"]
    
    var URL : String = ""
    var building : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyStyles()
        
        // Do any additional setup after loading the view.
        print(qrData)
        print(apiRoot!)
        
        
        // convert QR Data to JSON
        let data = qrData.data(using: .utf8)!
        var jsObject = [String : Any]()
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String : Any]
            {
                print(json) // use the json here
                jsObject = json
            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
        //URL = "\(apiRoot!)/buildings/\(jsObject["id"]!)"
        //print(URL)
        //getBuilding(URL)
        //print(building!)
    }
    
    @IBAction func servicePressed(_ sender: Any) {
    }
    
    func getBuilding(_ url : String) {
        AF.request(url, headers: [:]).responseJSON { response in
            if let d = response.result.value {
                self.building = d as? [String : Any]
                self.navigationItem.title = (self.building?["name"] as! String)
            }
        }
    }
    
    func applyStyles() {
        servicesButton.layer.cornerRadius = 15
        //R: 246 G: 192 B: 70
        let color = UIColor(red: 246/255, green: 192/255, blue: 70/255, alpha: 1).cgColor
        servicesButton.layer.borderColor = color
        servicesButton.layer.borderWidth = 3
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
