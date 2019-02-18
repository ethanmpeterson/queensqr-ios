//
//  ViewController.swift
//  queensqr-ios
//
//  Created by Ethan Peterson on 2019-02-17.
//  Copyright © 2019 Ethan Peterson. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var browse: UIButton!
    @IBOutlet weak var scan: UIButton!
    
    var apiRoot = ProcessInfo.processInfo.environment["API_ROOT"]
    
    var URL : String = ""
    var buildings : [[String : Any]]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        browse.layer.cornerRadius = 15
        scan.layer.cornerRadius = 15
        
        let borderColor = UIColor(red: 246/255, green: 192/255, blue: 70/255, alpha: 1).cgColor
        
        browse.layer.borderColor = borderColor
        browse.layer.borderWidth = 3
        
        scan.layer.borderColor = borderColor
        scan.layer.borderWidth = 3
        
        URL = "\(apiRoot!)/buildings/"
        print(URL)
        getBuildings(URL)
    }

    @IBAction func browsePressed(_ sender: Any) {
        if (buildings != nil) {
            performSegue(withIdentifier: "buildingList", sender: self)
        }
    }
    
    func getBuildings(_ url : String) {
        AF.request(url, headers: [:]).responseJSON { response in
            if let d = response.result.value {
                self.buildings = d as! [[String : Any]]
                print(self.buildings!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // OBJ TRANSFER HERE
        let b = buildings!
        if segue.destination is BuildingViewController {
            let dest = segue.destination as! BuildingViewController
            dest.buildings = b
        }
    }
}

