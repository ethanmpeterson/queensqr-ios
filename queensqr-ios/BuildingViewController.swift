//
//  BuildingViewController.swift
//  queensqr-ios
//
//  Created by Ethan Peterson on 2019-02-17.
//  Copyright © 2019 Ethan Peterson. All rights reserved.
//

import UIKit

import Alamofire

class BuildingViewController: UITableViewController {
    
    
    var qrData : String = ""
    var apiRoot = ProcessInfo.processInfo.environment["API_ROOT"]
    
    var URL : String = ""
    var building : [String : Any]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(qrData)
        print(apiRoot!)
        // Do any additional setup after loading the view.
        
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
        
        URL = "\(apiRoot!)/buildings/\(jsObject["id"]!)"
        print(URL)
        getBuilding(URL)
    }

    func getBuilding(_ url : String) {
        AF.request(url, headers: [:]).responseJSON { response in
            if let d = response.result.value {
                self.building = d as? [String : Any]
            }
        }
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
