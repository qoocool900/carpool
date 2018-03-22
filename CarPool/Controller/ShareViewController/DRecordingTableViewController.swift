//
//  DRecordingTableViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/16.
//

import UIKit

let reuseIdentifier = "driverSetupCell"

class DRecordingTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // get memeberNo
        let defaults = UserDefaults.standard
        let driverMemberNo = defaults.integer(forKey: "memberNo")
        print(driverMemberNo)
        
        //
        //        Communicator.shared.getMyTrips(memberNo: driverMemberNo, role: 1) { (error, result) in
        //            if let error = error {
        //                NSLog("getDriverSetRecord fail: \(error)")
        //                self.showAlert(message: "伺服器連線失敗")
        //                return
        //            }
        //            // success
        //            let content = result!["content"] as![String:Any]
        //            // Feedbacks of responses from the server
        //            let response = result!["response"] as! [String:Any]
        //            let code = response["code"] as! Int
        //            if code == 0 {
        //                //success
        //                let driverDeparture = content["boarding"] as! String
        //                let driverDestination = content["destination"] as! String
        //                let driverSetFee = content["fee"] as! String
        //                let driverSetPeople = content["people"] as! String
        //                let driverSetDate = content ["date"] as! String
        //                self.driverDeparture.text = driverDeparture
        //                self.driverDestination.text = driverDestination
        //                self.driverSetFee.text = driverSetFee
        //                self.driverSetPeople.text = driverSetPeople
        //                self.driverSetDate.text = driverSetDate
        //
    }
    
    
    
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //}DriverSetItem
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //...
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBOutlet weak var driverSetDate: UILabel!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DRecordingTableViewCell {
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    
}
