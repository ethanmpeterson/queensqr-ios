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
    
    var rowSelected = -1
    
    var apiRoot = ProcessInfo.processInfo.environment["API_ROOT"]
    
    var URL : String = ""
    var buildings : [[String : Any]]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Building List"
        print(apiRoot!)
        print(buildings!)
        // Do any additional setup after loading the view.
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if indexPath.row == 0 {
            let name = buildings[indexPath.row]["name"] as! String
            cell?.textLabel!.text = name
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            rowSelected = indexPath.row
            performSegue(withIdentifier: "bView", sender: self)
        }
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let dataIndex = indexPath.row - 1
//        if indexPath.row == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
//                return UITableViewCell()
//            }
//            cell.textLabel?.text = tableViewData[indexPath.section].title
//            cell.textLabel?.textAlignment = NSTextAlignment.center
//            cell.textLabel?.adjustsFontSizeToFitWidth = true
//            cell.textLabel?.font.withSize(24.0)
//            return cell
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
//                return UITableViewCell()
//            }
//            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
//            cell.textLabel?.textAlignment = NSTextAlignment.left
//            //cell.layoutMargins.left = 30
//            return cell
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            if tableViewData[indexPath.section].opened {
//                tableViewData[indexPath.section].opened = false
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            } else {
//                tableViewData[indexPath.section].opened = true
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            }
//        }
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is SingleBuildingViewController {
            let dest = segue.destination as! SingleBuildingViewController
            dest.building = buildings![rowSelected]
        }
    }
    

}
