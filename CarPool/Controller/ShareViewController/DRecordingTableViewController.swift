//
//  DRecordingTableViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/16.
//

import UIKit

let driverRecordCellIndentifier = "driverSetupCell"

class DRecordingTableViewController: UITableViewController {
    
    //var recordings = URL()

    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //...
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: driverRecordCellIndentifier, for: indexPath) as? DRecordingTableViewCell{
//            
//            return cell
//        }
//        
//        return UITableViewCell()
//    }
    
    
}
