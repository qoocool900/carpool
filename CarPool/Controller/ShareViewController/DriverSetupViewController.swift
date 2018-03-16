//
//  DriverSetupViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/6.
//

import UIKit

class DriverSetupViewController: UIViewController {

    @IBOutlet weak var Destination: UITextField!
    
    @IBOutlet weak var CarNumber: UITextField!
    
    @IBOutlet weak var PeopleNumber:
    UITextField!
 
    @IBOutlet weak var FeeField: UITextField!
    
    
    @IBAction func SaveButton(_ sender: Any) {
        
        guard Destination.text != "" else{
            return
        }
        
        guard CarNumber.text != "" else{
            return
        }
        
        guard PeopleNumber.text != "" else{
            return
        }
        
        guard FeeField.text != "" else {
            return
        }
        
        var Drivertrip = DriverTrip(tripId: 0, memberNo: 1, destination: "", carNo: "", people: 1, fee: 11, status: 1, date: "")
        
        Drivertrip.destination = Destination.text!
        Drivertrip.carNo = CarNumber.text!
        Drivertrip.people = Int(PeopleNumber.text!)!
        Drivertrip.fee = Int (FeeField.text!)!
        
        
        Communicator.shared.modifyDriverTrip(Drivertrip, mode: "C") { (error, result) in
            if let error = error {
                NSLog("Login fail: \(error)")
//                let msg = result!["msg"] as! String
//                self.showAlert(message: msg)
            self.showAlert(message: "發起失敗")
            return
                }
        NSLog("司機發起成功")
            //let msg = result!["msg"] as! String
           // self.showAlert(message: msg)
        self.showAlert(message: "發起成功")
     }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Destination.placeholder = "目的地"
        Destination.font = UIFont(name: "System", size: 25)
        Destination.placeholder = "請輸入您要去的目的地"
        
        CarNumber.font = UIFont(name: "System", size: 25)
        CarNumber.placeholder = "請輸入您的車牌號碼"
        
        
        PeopleNumber.font = UIFont(name: "System", size: 25)
        PeopleNumber.placeholder = "輸入可以乘載的人數"
        
        FeeField.font = UIFont(name: "System", size: 25)
        FeeField.placeholder = "請輸入費用, 最高為5000元"
        
       
//
//        Communicator.shared.checkUser(mail: "a", password: "a") { (error, result) in
//            if let error = error {
//                NSLog("checkUser fail: \(error)")
//                let msg = result!["msg"] as? String
//                return
//            }
//            // success
//            print(result!)
//            guard let memberNo = result!["memberNo"] as? Int else {
//                return
//            }
//            guard let memberName = result!["memberNo"] as? Int else {
//                return
//            }

//        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
            textField.resignFirstResponder()
            return true
        }
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(false)
        }
        
        func didReceiveMemoryWarning() {
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
}
