//
//  PRecordingViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/22.
//

import UIKit



class PRecordingViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var SetRecord = [Trip]()
//    var passengerSetRecord = DriverTrip(tripId: "", memberNo: 0, departure: "", destination: "", carNo: "", people: 0, fee: 0, status: "", date: "", departureLat: 0.0, departureLon: 0.0, destinationLat: 0.0, destinationLon: 0.0)
    
    //    let boarding = ["Hsichu", "Taipei"]
    //    let destination = ["Apple", "Google"]
    //    let date = ["2017/03/20","2017/03/22"]
    //    let fee = [20000,500000]
    //    let people = [5,10 ]
    
    @IBOutlet weak var PRecordingTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SetRecord.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  PRecordingTableView.dequeueReusableCell(withIdentifier:"passengerSetCell" , for: indexPath) as? PRecordingTableViewCell else{
            
            return UITableViewCell()
        }
        
        cell.passengerBoarding.text = SetRecord[indexPath.row].boarding
        cell.passengerDestination.text = SetRecord[indexPath.row].destination
        cell.passengerSetDate.text = SetRecord[indexPath.row].date
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PRecordingTableView.delegate = self
        PRecordingTableView.dataSource = self
        
        
        // get memeberNo
        let defaults = UserDefaults.standard
        let passengerMemberNo = defaults.integer(forKey: "memberNo")
        print(passengerMemberNo)
        
        
        
        //get PassengerMember setup data
        Communicator.shared.getMyTrips(memberNo: passengerMemberNo, role: 0) { (error, result) in
            if let error = error {
                NSLog("getPassengerSetRecord fail: \(error)")
                self.showAlert(message: "伺服器連線失敗")
                return
            }
            // success
            guard let content = result!["content"]as?[[String:Any]]
                else{
                    return
            }
            guard let response = result!["response"]as? [String:Any] else{
                return
            }
            let code = response["code"] as?Int
            if code == 0 {
                //success
                self.SetRecord = Common.shared.getMyPassengerTrips(passengerTripsArray: content)
//                var passengerSetRecord: DriverTrip!
//                for guestRecord in content{
//                    let passengerTripId = guestRecord["trip_ip"] as! String
//                    let passengerBoarding = guestRecord["boarding"] as! String
//                    let passengerDestination = guestRecord["destination"] as! String
//                    let Setdate = guestRecord["date"] as! String
//                    let people = guestRecord["people"] as! Int
//
//
//                    passengerSetRecord = DriverTrip(tripId: passengerTripId, memberNo: passengerMemberNo, departure: passengerBoarding, destination: passengerDestination, carNo: "", people: people, fee: 0,  status: "", date: Setdate, departureLat: 0.0, departureLon: 0.0, destinationLat: 0.0, destinationLon: 0.0)
                
//                    self.SetRecord.append(passengerSetRecord)
                    self.PRecordingTableView.reloadData()
                   
                }
                
                //            let boarding = passengerSetRecord.departure
                //            let destination = passengerSetRecord.destination
                //            let fee = passengerSetRecord.fee
                //            let date = passengerSetRecord.date
                //            let people = passengerSetRecord.people
                //
        
                
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 
 
 
 */
