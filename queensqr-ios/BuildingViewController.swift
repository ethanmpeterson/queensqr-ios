//
//  BuildingViewController.swift
//  queensqr-ios
//
//  Created by Ethan Peterson on 2019-02-17.
//  Copyright © 2019 Ethan Peterson. All rights reserved.
//

import UIKit

import Alamofire

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class BuildingViewController: UITableViewController {
    
    
    var qrData : String = ""
    var apiRoot = ProcessInfo.processInfo.environment["API_ROOT"]
    
    var URL : String = ""
    var building : [String : Any]?
    
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [
            cellData(opened: false, title: "General Information", sectionData: ["1", "2", "3"]),
            cellData(opened: false, title: "Alias", sectionData: ["1", "2", "3"]),
            cellData(opened: false, title: "Services", sectionData: ["1", "2", "3"]),
        ]
        
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
                self.navigationItem.title = (self.building?["name"] as! String)
                self.tableViewData[0].sectionData = [
                    self.building!["address"] as! String,
                    self.building!["faculty"] as! String,
                    self.building!["history"] as! String,
                ]
                self.tableViewData[1].sectionData = self.building!["alias"] as! [String]
                
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = tableViewData[indexPath.section].title
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
            cell.layoutMargins.left = 30
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
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
