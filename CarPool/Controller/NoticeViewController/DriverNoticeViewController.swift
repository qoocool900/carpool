//
//  DriverNoticeViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class DriverNoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var carCapacityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    let sectionArray = ["我收到的請求", "我發出的邀請"]
    var myTrip = DriverNotice.driverShared()
    var receivedItem = PassengerNotice.driverReceivedNotice()
    var requestItem = PassengerNotice.driverRequestNotice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDriverShare()
    }
    
    func getDriverShare() {
        startLocationLabel.text = myTrip.startLocation
        endLocationLabel.text = myTrip.endLocation
        dateLabel.text = myTrip.date
        carCapacityLabel.text = "\(myTrip.carCapacity)"
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! DriverNoticeReceivedTableViewCell
            let receivedNotice = receivedItem[indexPath.row]
            cell.noticeData = receivedNotice
            return cell
         default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! DriverNoticeRequestTableViewCell
            let requestNotice = requestItem[indexPath.row]
            cell.noticeData = requestNotice
            return cell
        }
    }
}


