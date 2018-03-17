//
//  PassengerSetupViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/6.
//

import UIKit

class PassengerSetupViewController: UIViewController {

    @IBOutlet weak var DestinationPassenger: UITextField!
    
    @IBOutlet weak var BoardingPoint: UITextField!
    
    
    @IBOutlet weak var PeopleNumber: UITextField!
    
    
  
    @IBAction func SavePassengerBtn(_ sender: Any) {
        
        let savePassengerRecord = Trip(tripId: "", memberNo: 0,  destination: "", boarding: "", people: 0, onMap:0 , status:0 , date: "")
        
        guard DestinationPassenger.text != "" else{
            return
        }
        
        guard BoardingPoint.text != "" else{
            return
        }
        guard PeopleNumber.text != "" else{
            return
        }
        
    
        savePassengerRecord.destination = DestinationPassenger.text!
        savePassengerRecord.boarding = BoardingPoint.text!
        savePassengerRecord.people = Int(PeopleNumber.text!)!
        
        Communicator.shared.modifyTrip(savePassengerRecord, mode: "C") { (error, result) in
            if let error = error {
                NSLog("doRegister fail: \(error)")
            
                NSLog("乘客發起失敗")
                self.showAlert(message: "發起失敗")
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
