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
    var buildings : [[String : Any]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        browse.layer.cornerRadius = 15
        scan.layer.cornerRadius = 15
        
        URL = "\(apiRoot!)/buildings/"
        print(URL)
        getBuildings(URL)
    }

    func getBuildings(_ url : String) {
        AF.request(url, headers: [:]).responseJSON { response in
            if let d = response.result.value {
                self.buildings = d as! [[String : Any]]
                print(self.buildings!)
            }
        }
    }
}

