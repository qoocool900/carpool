//
//  DRecordingTableViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/16.
//

import UIKit

//let reuseIdentifier = "driverSetupCell"

class DRecordingTableViewController: UITableViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var boarding = ["Hsinchu", "Taipei","Taichung" ]
        var destination  = ["天津", "上海","Holland"]
        var date = ["02/12","04/05","08/09"]
        var fee = [100,200,300]
        var people = [2,3,4]
        
        
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
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 0
        }
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "driverSetupCell", for: indexPath) as! DRecordingTableViewCell
            cell.driverBoarding.text = boarding[indexPath.count]
            cell.driverDestination.text = destination[indexPath.count]
          cell.driverFee.text  = String(fee[indexPath.count])
          cell.driverCapacity.text = String(people[indexPath.count])
            cell.driverSetdate.text = date[indexPath.count]
            
            
            return cell
        }
       
    }
    
}
