//
//  DriverSetupViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/6.
//

import UIKit
import CoreLocation

class DriverSetupViewController: UIViewController {
    
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var CarNumber: UITextField!
    @IBOutlet weak var departureText: UITextField!
    @IBOutlet weak var PeopleNumber:
    UITextField!
    @IBOutlet weak var FeeField: UITextField!
    
    
    @IBAction func SaveButton(_ sender: Any) {
        guard Destination.text != "" else{
            return
        }
        guard departureText.text != ""
            else{
                return
        }
        guard CarNumber.text != "" else{
            return
        }
        guard PeopleNumber.text != "" else{
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
        
        let BoarddingAddress = departureText.text
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
            defaults.set(destinationLat,forKey:"boardingLat")
            defaults.set(destinationLong, forKey: "boardingLong")
            print(boardingLat,boardingLong)
            
        }
        
        let saveDriverRecord = Trip(tripId: "", memberNo: 0,  destination: "", boarding: "", people: 0, onMap:0 , status:0 , date: "", boardingLat:0.0 , boardingLon: 0.0, destinationLat:0.0 , destinationLon:0.0 )
        saveDriverRecord.memberNo = driverMemberNo
        saveDriverRecord.destination = Destination.text!
        saveDriverRecord.boarding = departureText.text!
        saveDriverRecord.people = Int(PeopleNumber.text!)!
        saveDriverRecord.destinationLat = destinationLat
        saveDriverRecord.destinationLon = destinationLong
        saveDriverRecord.boardingLat = boardingLat
        saveDriverRecord.boardingLon = boardingLong
        
        
        //        savePassengerRecord.destinationLon = destinationLong
        
        
        Communicator.shared.modifyTrip(saveDriverRecord, mode: "C") { (error, result) in
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
        
        // get memeberNo
        let defaults = UserDefaults.standard
        let driverMemberNo = defaults.integer(forKey: "memberNo")
        print(driverMemberNo)
        //print(4567)
        
        //Destination.placeholder = "目的地"
        Destination.font = UIFont(name: "System", size: 25)
        Destination.placeholder = "請輸入您要去的目的地"
        
        departureText.font = UIFont(name: "System", size: 25)
        departureText.placeholder = "請輸入您的出發地"
        
        CarNumber.font = UIFont(name: "System", size: 25)
        CarNumber.placeholder = "請輸入您的車牌號碼"
        
        
        PeopleNumber.font = UIFont(name: "System", size: 25)
        PeopleNumber.placeholder = "數字"
        
        FeeField.font = UIFont(name: "System", size: 15)
        FeeField.placeholder = "(0~5000)"
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


