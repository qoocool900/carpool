//
//  DriverSetupViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/6.
//

import UIKit
import CoreLocation

class DriverSetupViewController: UIViewController {
    
    static var driverCarNo:String?
    static var destinationLat: Double?
    static var destinationLong:Double?
    static var boardingLat:Double?
    static var boardingLong:Double?
    
    @IBOutlet weak var DepartureText: UITextField!
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var CarNumber: UITextField!
    @IBOutlet weak var PeopleNumber: UITextField!
    @IBOutlet weak var FeeField: UITextField!
    @IBAction func SaveButton(_ sender: Any) {
        
        // get memberNo
        let defaults = UserDefaults.standard
        var driverMemberNo = defaults.integer(forKey: "memberNo")
        
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
        
        guard FeeField.text != "" else{
            showAlert(message: "沒有輸入金額")
            return
        }
        
        let DesitinationAddress = Destination.text
        let DestinationgeoCoder = CLGeocoder()
        DestinationgeoCoder.geocodeAddressString(DesitinationAddress!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    self.showAlert(message: "No data found!")
                    return
            }
            // Use your location
            DriverSetupViewController.destinationLat = location.coordinate.latitude
            DriverSetupViewController.destinationLong = location.coordinate.longitude
            
            doShare()
            print("destinationgLat,destinationLong",DriverSetupViewController.destinationLat,DriverSetupViewController.destinationLong)
        }
        
        func doShare() {
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
                DriverSetupViewController.boardingLat = location.coordinate.latitude
                DriverSetupViewController.boardingLong = location.coordinate.longitude
                print("boardingLat,boardingLong",DriverSetupViewController.boardingLat,DriverSetupViewController.boardingLong)
                
                
                let saveDriverRecord = DriverTrip(tripId: "", memberNo: 0, departure: "", destination: "", carNo: "", people: 0, fee: 0, status: "", date: "", departureLat: DriverSetupViewController.boardingLat!, departureLon: DriverSetupViewController.boardingLong!, destinationLat: DriverSetupViewController.destinationLat!, destinationLon: DriverSetupViewController.destinationLong!)
                
                saveDriverRecord.memberNo = driverMemberNo
                saveDriverRecord.destination = self.Destination.text!
                saveDriverRecord.departure = self.DepartureText.text!
                saveDriverRecord.people = Int(self.PeopleNumber.text!)!
                saveDriverRecord.carNo = self.CarNumber.text!
                saveDriverRecord.fee = Int(self.FeeField.text!)!
                saveDriverRecord.destinationLat = DriverSetupViewController.destinationLat!
                saveDriverRecord.destinationLon = DriverSetupViewController.destinationLong!
                saveDriverRecord.departureLat = DriverSetupViewController.boardingLat!
                saveDriverRecord.departureLon = DriverSetupViewController.boardingLong!
                
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
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        let defaults = UserDefaults.standard
        let driverMemberNo = defaults.integer(forKey: "memberNo")
        getCarData(memberNo: driverMemberNo)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get memeberNo
        let defaults = UserDefaults.standard
        let driverMemberNo = defaults.integer(forKey: "memberNo")
        print(driverMemberNo)
        
        getCarData(memberNo:driverMemberNo)
        if  DriverSetupViewController.driverCarNo != nil {
            CarNumber.text = DriverSetupViewController.driverCarNo
        }else{
            CarNumber.font = UIFont(name: "System", size: 8)
            CarNumber.placeholder = "請輸入車牌號碼"
        }
        
        Destination.font = UIFont(name: "System", size: 25)
        Destination.placeholder = "請輸入您要去的目的地"
        
        DepartureText.font = UIFont(name: "System", size: 25)
        DepartureText.placeholder = "請輸入您的出發地"
        
        PeopleNumber.font = UIFont(name: "System", size: 25)
        PeopleNumber.placeholder = "可乘載人數(數字)"
        
        FeeField.font = UIFont(name: "System", size: 15)
        FeeField.placeholder = "輸入費用(0~5000)"
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    func getCarData(memberNo: Int){
        let defaults = UserDefaults.standard
        let driverMemberNo = defaults.integer(forKey: "memberNo")
        
        Communicator.shared.getCarInfo(memberNo: driverMemberNo) { (error, result) in
            if let error = error {
                
                NSLog("伺服器問題:\(error)")
                return
            }
            //success
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                var carNo =  DriverSetupViewController.driverCarNo
                carNo = content["carNo"] as? String
                defaults.set(carNo , forKey: "DrivercarNo")
                self.CarNumber.text = carNo
                print("DrivercarNo",carNo)
            }
        }
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


