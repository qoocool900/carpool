//
//  PassengerRecordViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/7.
//

import UIKit

class PassengerRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let sectionArray = ["進行中記錄", "歷史紀錄"]
    var processingItem = PassengerRecord.allProcessingRecord()
    var historyItem = PassengerRecord.allHistoryRecord()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.estimatedRowHeight = 80
//        self.tableView.rowHeight = UITableViewAutomaticDimension
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
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerRecordCell", for: indexPath) as! PassengerRecordTableViewCell
            let historyRecord = historyItem[indexPath.row]
            cell.recordData = historyRecord
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerRecordCell", for: indexPath) as! PassengerRecordTableViewCell
//            let processingRecord = processingItem[indexPath.row]
//            cell.recordData = processingRecord
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            historyItem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

}
