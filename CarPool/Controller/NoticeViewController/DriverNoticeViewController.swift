//
//  DriverNoticeViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class DriverNoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DriverReceivedCellDelegate {
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var carCapacityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let loginMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
    let sectionArray = ["我收到的請求", "我發出的邀請"]
    var driverTripId = ""
    var receivedItem = [PassengerNotice]()
    var requestItem = [PassengerNotice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFromDataBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataFromDataBase()
    }
    
    func dataFromDataBase(){
        //Database data
        DriverNotice.getDriverSharedInfo(loginMemberNo: loginMemberNo) { (trip) in
            self.startLocationLabel.text = trip.departure
            self.endLocationLabel.text = trip.destination
            self.dateLabel.text = (trip.date as NSString).substring(with: NSRange(location:0, length:16))
            self.driverTripId = trip.tripId
            PassengerNotice.getDriverReceivedNoticeInfo(driverTripId: self.driverTripId) { (received) in
                self.receivedItem = received
                self.tableView.reloadData()
            }
            PassengerNotice.getDriverRequestNoticeInfo(driverTripId: self.driverTripId) { (request) in
                self.requestItem = request
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - TableView Setting
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return sectionArray[0]
        default:
            return sectionArray[1]
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        switch section {
        case 0:
            cell?.textLabel?.text = sectionArray[0]
        default:
            cell?.textLabel?.text = sectionArray[1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return receivedItem.count
        default:
            return requestItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! DriverNoticeReceivedTableViewCell
            let receivedNotice = receivedItem[indexPath.row]
            cell.noticeData = receivedNotice
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! DriverNoticeRequestTableViewCell
            let requestNotice = requestItem[indexPath.row]
            cell.noticeData = requestNotice
            return cell
        }
    }
    
    // MARK: - DriverReceivedCellDelegate
    func updateReceivedAcceptStatus(reqNo: Int, status: Int, tripId: String) {
        Communicator.shared.updateStatus(reqNo: reqNo, tripId: tripId, status: status) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            guard result?.isEmpty == false else {
                return
            }
            let response = result!["response"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                self.showAlert(message: "配對成功!\n請至「乘車紀錄」查詢")
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
        self.tableView.reloadData()
    }
    
    func updateReceivedRefuseStatus(reqNo: Int, status: Int, tripId: String) {
        Communicator.shared.updateStatus(reqNo: reqNo, tripId: tripId, status: status) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            guard result?.isEmpty == false else {
                return
            }
            let response = result!["response"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                self.showAlert(message: "已拒絕邀請/請求")
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
        self.tableView.reloadData()
    }
}


