//
//  DriverDetailTableViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class DriverDetailRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
//Test Data
    var driverDeatilItem = DriverRecordDetail.allTripPassengerRecord()
    
//Data base
//    var driverDeatilItem = DriverRecordDetail.getAllTripPassengerInfo(seqNo: 1)

    var seqNo = 0
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        cell?.textLabel?.text = "乘客清單"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driverDeatilItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverDetailRecordCell", for: indexPath) as! DriverRecordDetailTableViewCell
        let record = driverDeatilItem[indexPath.row]
        cell.recordData = record
        return cell
    }

    
}


