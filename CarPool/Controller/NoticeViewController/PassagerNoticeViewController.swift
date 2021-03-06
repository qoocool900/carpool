//
//  PassagerNoticeViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class PassagerNoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,PassengerReceivedCellDelegate{
    
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var passengerCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let loginMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
    var seqNo = 0
    var driverPhone = ""
    var status = 0
    
    let sectionArray = ["我收到的邀請", "我發出的請求"]
    var passengerTripId = ""
    var receivedItem = [DriverNotice]()
    var requestItem = [DriverNotice]()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFromDataBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
           dataFromDataBase()
        if #available(iOS 10.0, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
                self.dataFromDataBase()
            }
        } else {
            timer = Timer.scheduledTimer(timeInterval: 5,target: self,selector: #selector(self.dataFromDataBase),userInfo: nil,repeats: true)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    @objc func dataFromDataBase(){
        //Database data
        PassengerNotice.getPassengerSharedInfo(loginMemberNo: loginMemberNo) { (trip) in
            self.startLocationLabel.text = trip.boarding
            self.endLocationLabel.text = trip.destination
            self.dateLabel.text = (trip.date as NSString).substring(with: NSRange(location:0, length:16))
            self.passengerCountLabel.text = "\(trip.people)"
            self.passengerTripId = trip.tripId
            print("乘客TripId: \(trip.tripId)")
            self.tableView.reloadData()
            DriverNotice.getPassengerReceivedNoticeInfo(passengerTripId: self.passengerTripId) { (received) in
                self.receivedItem = received
                self.tableView.reloadData()
            }
            DriverNotice.getPassengerRequestNoticeInfo(passengerTripId: self.passengerTripId) { (request) in
                self.requestItem = request
                self.tableView.reloadData()
            }
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! PassengerNoticeReceivedTableViewCell
            let receivedNotice = receivedItem[indexPath.row]
            cell.noticeData = receivedNotice
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! PassengerNoticeRequestTableViewCell
            let requestNotice = requestItem[indexPath.row]
            cell.noticeData = requestNotice
            return cell
        }
    }
    
    // MARK: - PassengerReceivedCellDelegate
    func updateReceivedAcceptStatus(Cell:UITableViewCell,reqNo: Int, status: Int, tripId: String) {
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
                let center = NotificationCenter.default
                center.post(name: NSNotification.Name(rawValue:"MatchSuccess"), object: nil, userInfo: ["reqNo": reqNo,"tripId":tripId])
                print("Notification: reqNo:\(reqNo), tripId:\(tripId)")
                self.showAlert(message: "配對成功!\n請至「乘車紀錄」查詢")
                self.dataFromDataBase()
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    func updateReceivedRefuseStatus(Cell:UITableViewCell,reqNo: Int, status: Int, tripId: String) {
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
                self.dataFromDataBase()
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
}

