//
//  PassengerSetupViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/6.
//

import UIKit
import CoreLocation

class PassengerSetupViewController: UIViewController {
    
    @IBOutlet weak var DestinationPassenger: UITextField!
    @IBOutlet weak var BoardingPoint: UITextField!
    @IBOutlet weak var PeopleNumber: UITextField!
    @IBAction func SavePassengerBtn(_ sender: Any) {
        
        guard DestinationPassenger.text != "" else{
            return
        }
        guard BoardingPoint.text != "" else{
            return
        }
        guard PeopleNumber.text != "" else{
            return
        }
        
        // get memberNo
        let defaults = UserDefaults.standard
        var passengerMemberNo = defaults.integer(forKey: "memberNo")
        var destinationLat = defaults.double(forKey: "destinationLat")
        var destinationLong = defaults.double(forKey: "destinationLong")
        var boardingLat = defaults.double(forKey:"boardingLat")
        var boardingLong = defaults.double(forKey:"boardingLong")
        defaults.synchronize()
        //        print(PassengerMemberNo)
        
        let DesitinationAddress = DestinationPassenger.text
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
        
        let BoarddingAddress = BoardingPoint.text
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
        
        let savePassengerRecord = Trip(tripId: "1", memberNo:0, destination: "", boarding: "", people: 0, onMap: "1", status: "0", date: "", boardingLat: 0.0, boardingLon: 0.0, destinationLat: 0.0, destinationLon: 0.0)
        savePassengerRecord.memberNo = passengerMemberNo
        savePassengerRecord.destination = DestinationPassenger.text!
        savePassengerRecord.boarding = BoardingPoint.text!
        savePassengerRecord.people = Int(PeopleNumber.text!)!
        savePassengerRecord.destinationLat = destinationLat
        savePassengerRecord.destinationLon = destinationLong
        savePassengerRecord.boardingLat = boardingLat
        savePassengerRecord.boardingLon = boardingLong
        
        
        //        savePassengerRecord.destinationLon = destinationLong
        
        
        Communicator.shared.modifyTrip(savePassengerRecord, mode: "C") { (error, result) in
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
        
        DestinationPassenger.font = UIFont(name: "System", size: 25)
        DestinationPassenger.placeholder = "請輸入您要去的目的地"
        
        BoardingPoint.font = UIFont(name: "System", size: 25)
        BoardingPoint.placeholder = "請輸入您的上車地點"
        
        PeopleNumber.font = UIFont(name: "System", size: 25)
        PeopleNumber.placeholder = "數字"
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
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

