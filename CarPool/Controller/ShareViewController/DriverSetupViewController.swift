//
//  DriverSetupViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/6.
//

import UIKit
import CoreLocation

class DriverSetupViewController: UIViewController {
    
    
    @IBOutlet weak var DepartureText: UITextField!
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var CarNumber: UITextField!
    @IBOutlet weak var PeopleNumber: UITextField!
    @IBOutlet weak var FeeField: UITextField!
    @IBAction func SaveButton(_ sender: Any) {
        guard Destination.text != "" else{
            showAlert(message: "沒有目的地")
            return
        }
        guard DepartureText.text != ""
            else{
                showAlert(message: "沒有出發地")
                return
        }
        guard CarNumber.text != "" else{
             showAlert(message: "沒有車牌號碼")
            return
        }
        guard PeopleNumber.text != "" else{
             showAlert(message: "沒有輸入人數")
            return
        }
        
        // get memberNo
        let defaults = UserDefaults.standard
        var driverMemberNo = defaults.integer(forKey: "memberNo")
        var destinationLat = defaults.double(forKey: "destinationLat")
        var destinationLong = defaults.double(forKey: "destinationLong")
        var boardingLat = defaults.double(forKey:"boardingLat")
        var boardingLong = defaults.double(forKey:"boardingLong")
        defaults.synchronize()
        //        print(PassengerMemberNo)
        
        let DesitinationAddress = Destination.text
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(DesitinationAddress!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    self.showAlert(message: "No data found!")
                    return
            }
            // Use your location
            var destinationLat = location.coordinate.latitude
            var destinationLong = location.coordinate.longitude
            print(destinationLat,destinationLong)
             defaults.set(destinationLat,forKey:"destinationLat")
            defaults.set(destinationLong, forKey: "destinationLong")
            defaults.synchronize()
            
        }
        
        let BoarddingAddress = DepartureText.text
        let BoardingGeoCoder = CLGeocoder()
        BoardingGeoCoder.geocodeAddressString(BoarddingAddress!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    // assertionFailure()
                    self.showAlert(message: "No data found!")
                    return
            }
            // Use your location
            var boardingLat = location.coordinate.latitude
            var boardingLong = location.coordinate.longitude
            defaults.set(boardingLat,forKey:"boardingLat")
            defaults.set(boardingLong, forKey: "boardingLong")
            print(boardingLat,boardingLong)
            
        }
        
        let saveDriverRecord = DriverTrip(tripId: "", memberNo: 0, departure: "", destination: "", carNo: "", people: 0, fee: 0, status: "", date: "", departureLat: 0.0, departureLon: 0.0, destinationLat: 0.0, destinationLon: 0.0)
        saveDriverRecord.memberNo = driverMemberNo
        saveDriverRecord.destination = Destination.text!
        saveDriverRecord.departure = DepartureText.text!
        saveDriverRecord.people = Int(PeopleNumber.text!)!
        saveDriverRecord.carNo = CarNumber.text!
        saveDriverRecord.fee = Int(FeeField.text!)!
        saveDriverRecord.destinationLat = destinationLat
        saveDriverRecord.destinationLon = destinationLong
        saveDriverRecord.departureLat = boardingLat
        saveDriverRecord.departureLon = boardingLong
        
        
        //        savePassengerRecord.destinationLon = destinationLong
        
        
        Communicator.shared.modifyDriverTrip(saveDriverRecord, mode: "C") { (error, result) in
            if let error = error {
                NSLog("doSetUp fail: \(error)")
                self.showAlert(message:"伺服器有誤")
            }
            // success
            NSLog("乘客發起成功")
            self.showAlert(message: "發起成功")
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // get memeberNo
//        let defaults = UserDefaults.standard
//        let driverMemberNo = defaults.integer(forKey: "memberNo")
//        print(driverMemberNo)
//        //print(4567)
        
        //Destination.placeholder = "目的地"
        Destination.font = UIFont(name: "System", size: 25)
        Destination.placeholder = "請輸入您要去的目的地"
        
        DepartureText.font = UIFont(name: "System", size: 25)
        DepartureText.placeholder = "請輸入您的出發地"
        
        CarNumber.font = UIFont(name: "System", size: 25)
        CarNumber.placeholder = "請輸入您的車牌號碼"
        
        
        PeopleNumber.font = UIFont(name: "System", size: 25)
        PeopleNumber.placeholder = "可乘載人數"
        
        FeeField.font = UIFont(name: "System", size: 15)
        FeeField.placeholder = "輸入費用(0~5000)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}


