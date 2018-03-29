//
//  PassengerRecordViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/7.
//

import UIKit

class PassengerRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let loginMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
    let sectionArray = ["進行中記錄", "歷史紀錄"]
    
    var driverMemberNo = 0
    var driverTripId = ""
    var processingItem = [PassengerRecord]()
    var historyItem = [PassengerRecord] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFromDataBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataFromDataBase()
    }
    
    func dataFromDataBase()  {
        print(loginMemberNo)
        // Test Data
        //    processingItem = PassengerRecord.allProcessingRecord()
        //    historyItem = PassengerRecord.allHistoryRecord()
        // Data base
        PassengerRecord.getPassengerProcessingInfo(loginMemberNo: loginMemberNo) { (recordings) in
            self.processingItem = recordings
            self.tableView.reloadData()
        }
        PassengerRecord.getPassengerHistoryInfo(loginMemberNo: loginMemberNo) { (recordings) in
            self.historyItem = recordings
            self.tableView.reloadData()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerRecordCell", for: indexPath) as! PassengerRecordTableViewCell
            let processingRecord = processingItem[indexPath.row]
            cell.recordData = processingRecord
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerRecordCell", for: indexPath) as! PassengerRecordTableViewCell
            let historyRecord = historyItem[indexPath.row]
            cell.recordData = historyRecord
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        switch indexPath.section {
//        case 0:
//            return
//        default:
//            if editingStyle == .delete{
//                historyItem.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EvaluaionViewController") as? EvaluaionViewController{
            switch indexPath.section {
            case 0:
                driverMemberNo = processingItem[indexPath.row].driverMemberNo
                driverTripId = processingItem[indexPath.row].driverTripId
            default:
                driverMemberNo = historyItem[indexPath.row].driverMemberNo
                driverTripId = historyItem[indexPath.row].driverTripId
            }
            vc.driverMemberNo = driverMemberNo
            vc.driverTripId = driverTripId
            print("driverMemberNo: \(driverMemberNo),driverTripId:\(driverTripId)")
            show(vc, sender: nil)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let selectedIndex = tableView.indexPathForSelectedRow!
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "DriverDetailRecordViewController") as? EvaluaionViewController{
//            switch selectedIndex.section {
//            case 0:
//                driverMemberNo = processingItem[selectedIndex.row].driverMemberNo
//                driverTripId = processingItem[selectedIndex.row].driverTripId
//            default:
//                driverMemberNo = historyItem[selectedIndex.row].driverMemberNo
//                driverTripId = historyItem[selectedIndex.row].driverTripId
//            }
//            vc.driverMemberNo = driverMemberNo
//            vc.driverTripId = driverTripId
//            print("driverMemberNo: \(driverMemberNo),driverTripId:\(driverTripId)")
//        }
//    }
}


