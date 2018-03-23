//
//  DriverRecordViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/7.
//

import UIKit



class DriverRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let loginMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
    let sectionArray = ["進行中記錄", "歷史紀錄"]
    var processingItem = [DriverRecord]()
    var historyItem = [DriverRecord] ()
    var driverTripId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Test Data
        //    processingItem = DriverRecord.allProcessingRecord()
        //    historyItem = DriverRecord.allHistoryRecord()
        // Data base
        DriverRecord.getDriverProcessingInfo(loginMemberNo: loginMemberNo) { (recordings) in
            self.processingItem = recordings
        }
        DriverRecord.getDriverHistoryInfo(loginMemberNo: loginMemberNo) { (recordings) in
            self.historyItem = recordings
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return sectionArray[0]
        case 1:
            return sectionArray[1]
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        switch section {
        case 0:
            cell?.textLabel?.text = sectionArray[0]
        case 1:
            cell?.textLabel?.text = sectionArray[1]
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return processingItem.count
        case 1:
            return historyItem.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DriverRecordCell", for: indexPath) as! DriverRecordTableViewCell
            let processingRecord = processingItem[indexPath.row]
            cell.recordData = processingRecord
            driverTripId = (cell.recordData?.driverTripId)!
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DriverRecordCell", for: indexPath) as! DriverRecordTableViewCell
            let historyRecord = historyItem[indexPath.row]
            cell.recordData = historyRecord
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DriverDetailRecordViewController") as? DriverDetailRecordViewController{
            switch indexPath.section {
            case 0:
                driverTripId = processingItem[indexPath.row].driverTripId
            default:
tripId = historyItem[indexPath.row].seqNo
            }
            vc.driverTripId = driverTripId
            print("seqNo: \(driverTripId)")
        }
    }
}

