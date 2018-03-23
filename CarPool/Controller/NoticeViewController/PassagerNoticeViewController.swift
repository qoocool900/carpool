//
//  PassagerNoticeViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class PassagerNoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Test sata
//        myTrip = PassengerNotice.passengerShared()
//        startLocationLabel.text = myTrip.boarding
//        endLocationLabel.text = myTrip.destination
//        dateLabel.text = myTrip.date
//        passengerCountLabel.text = "\(myTrip.people)"
//        receivedItem = DriverNotice.passengerReceivedNotice()
//        requestItem = DriverNotice.passengerRequestNotice()
        
        //Database data
        PassengerNotice.getPassengerSharedInfo(loginMemberNo: loginMemberNo) { (trip) in
            self.startLocationLabel.text = trip.boarding
            self.endLocationLabel.text = trip.destination
            self.dateLabel.text = trip.date
            print(trip.people)
            self.passengerCountLabel.text = "\(trip.people)"
            self.passengerTripId = trip.tripId
            print("Notice Passenger People: \(trip.people)")
        }
        DriverNotice.getPassengerReceivedNoticeInfo(passengerTripId: passengerTripId) { (received) in
            self.receivedItem = received
        }
        DriverNotice.getPassengerRequestNoticeInfo(passengerTripId: passengerTripId) { (request) in
            self.requestItem = request
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
            return receivedItem.count
        case 1:
            return requestItem.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! PassengerNoticeReceivedTableViewCell
            let receivedNotice = receivedItem[indexPath.row]
            cell.noticeData = receivedNotice
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! PassengerNoticeRequestTableViewCell
            let requestNotice = requestItem[indexPath.row]
            cell.noticeData = requestNotice
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! PassengerNoticeReceivedTableViewCell
            let receivedNotice = receivedItem[indexPath.row]
            cell.noticeData = receivedNotice
            return cell
        }
    }
}

