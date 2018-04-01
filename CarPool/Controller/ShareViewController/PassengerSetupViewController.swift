//
//  PassengerSetupViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/6.
//

import UIKit
import CoreLocation

class PassengerSetupViewController: UIViewController {
    
    static var destinationLat: Double?
    static var destinationLong:Double?
    static var boardingLat:Double?
    static var boardingLong:Double?
    
    @IBOutlet weak var DestinationPassenger: UITextField!
    @IBOutlet weak var BoardingPoint: UITextField!
    @IBOutlet weak var PeopleNumber: UITextField!
    @IBAction func SavePassengerBtn(_ sender: Any) {
        
        guard DestinationPassenger.text != "" else{
            showAlert(message: "沒有目的地")
            return
        }
        guard BoardingPoint.text != "" else{
            showAlert(message: "沒有出發地")
            return
        }
        guard PeopleNumber.text != "" else{
            showAlert(message: "沒有輸入人")
            return
        }
        
        // get memberNo
        let defaults = UserDefaults.standard
        var passengerMemberNo = defaults.integer(forKey: "memberNo")
        print(passengerMemberNo)
        
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
            PassengerSetupViewController.destinationLat = location.coordinate.latitude
            PassengerSetupViewController.destinationLong = location.coordinate.longitude
            
            doShare()
            print("pDestinationLat,pDestinationLong",PassengerSetupViewController.destinationLat,PassengerSetupViewController.destinationLong)
        }
        
        func doShare() {
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
                PassengerSetupViewController.boardingLat = location.coordinate.latitude
                PassengerSetupViewController.boardingLong = location.coordinate.longitude
                
                print("pBoardingLat,pBoardingLong",PassengerSetupViewController.boardingLat,PassengerSetupViewController.boardingLong)
                
                
                
                let savePassengerRecord = Trip(tripId: "1", memberNo:0, destination: "", boarding: "", people: 0, onMap: "1", status: "0", date: "", boardingLat: PassengerSetupViewController.boardingLat!, boardingLon:PassengerSetupViewController.boardingLong! , destinationLat: PassengerSetupViewController.destinationLat!, destinationLon: PassengerSetupViewController.destinationLong!)
                savePassengerRecord.memberNo = passengerMemberNo
                savePassengerRecord.destination = self.DestinationPassenger.text!
                savePassengerRecord.boarding = self.BoardingPoint.text!
                savePassengerRecord.people = Int(self.PeopleNumber.text!)!
                savePassengerRecord.destinationLat = PassengerSetupViewController.destinationLat!
                savePassengerRecord.destinationLon = PassengerSetupViewController.destinationLong!
                savePassengerRecord.boardingLat = PassengerSetupViewController.boardingLat!
                savePassengerRecord.boardingLon = PassengerSetupViewController.boardingLong!
                
                
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
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get memeberNo
        let defaults = UserDefaults.standard
        let passengerMemberNo = defaults.integer(forKey: "memberNo")
        print(passengerMemberNo)
        
        DestinationPassenger.font = UIFont(name: "System", size: 25)
        DestinationPassenger.placeholder = "請輸入您要去的目的地"
        
        BoardingPoint.font = UIFont(name: "System", size: 25)
        BoardingPoint.placeholder = "請輸入您的上車地點"
        
        PeopleNumber.font = UIFont(name: "System", size: 25)
        PeopleNumber.placeholder = "請輸入數字"
        
        
        
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

