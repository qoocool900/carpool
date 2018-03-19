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
//        guard BoardingPoint.text != "" else{
//            return
//        }
//        guard PeopleNumber.text != "" else{
//            return
//        }
        let DesitinationAddress = DestinationPassenger.text
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(DesitinationAddress!) { (placemarks, error) in
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
            print(location)
            let LocationString = String(describing: location)
//            let String = "Location: < 37.78583400,-122.40641700> /- 5.00m (speed
//            -1.00 mps / course -1.00) @ 5/8/17, 10:26:50 PM Pacific Daylight
//            Time"
            
            let latLongString = LocationString.components(separatedBy: "< ")[1].components(separatedBy: ">")[0]
            
            let lat = latLongString.components(separatedBy: ",")[0]
            let long = latLongString.components(separatedBy: ",")[1]
            if let latitude =  Double(lat), let longitude = Double(long) {
                let coordinate:CLLocation = CLLocation(latitude: latitude, longitude: longitude)
                print(latitude ,longitude)
                
            }
            print(5677)
            let defaults = UserDefaults.standard
            defaults.set(location, forKey: "location")
            defaults.synchronize()
            print(defaults.string(forKey: "location"))
            self.showAlert(message: "Yes! ")
            // Use your location
        }
        
//        let savePassengerRecord = Trip(tripId: "", memberNo: 0,  destination: "", boarding: "", people: 0, onMap:0 , status:0 , date: "", boardingLat: 0.0, boardingLon: 0.0, destinationLat: 0.0, destinationLon: 0.0)
//
//        savePassengerRecord.destination = DestinationPassenger.text!
//        savePassengerRecord.boarding = BoardingPoint.text!
//        savePassengerRecord.people = Int(PeopleNumber.text!)!
//
//        Communicator.shared.modifyTrip(savePassengerRecord, mode: "C") { (error, result) in
//            if let error = error {
//                NSLog("doRegister fail: \(error)")
//
//                NSLog("乘客發起失敗")
//                self.showAlert(message: "發起失敗")
//            }
//            // success
//            NSLog("乘客發起成功")
//            self.showAlert(message: "發起成功")
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DestinationPassenger.font = UIFont(name: "System", size: 25)
        DestinationPassenger.placeholder = "請輸入您要去的目的地"
        
        BoardingPoint.font = UIFont(name: "System", size: 25)
        BoardingPoint.placeholder = "請輸入您的上車地點"
        
        PeopleNumber.font = UIFont(name: "System", size: 25)
        PeopleNumber.placeholder = "請輸入您的人數"
        
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
