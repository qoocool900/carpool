//
//  GuardViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/6.
//

import UIKit
import AVFoundation

class GuardViewController: UIViewController{
    @IBOutlet weak var guareNameLabel: UILabel!
    @IBOutlet weak var guarePhoneLabel: UILabel!
    @IBOutlet weak var scanBtn: UIButton!
    
    let loginMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
    var scanMemberNo = 1
    var scanMemberName = ""
    var scanMemberPhone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGuardInfoData(memberNo: loginMemberNo)
    }
    
    @IBAction func phonePressed(_ sender: Any) {
        scanMemberPhone = guarePhoneLabel.text!
        callPhone(phoneNo: scanMemberPhone)
    }
    
    @IBAction func scanPressed(_ sender: Any) {
        performSegue(withIdentifier: "goScanning", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? QRcodeViewController {
            vc.resultHandler = { (success:Bool, memberInfo:[String]) -> Void in
                
                NSLog("result: \(memberInfo)]")
                self.scanMemberName = memberInfo[0]
                self.scanMemberPhone = memberInfo[1]
                self.guareNameLabel.text = self.scanMemberName
                self.guarePhoneLabel.text = self.scanMemberPhone
            }
        }
    }
    
    // Get GuardData already been set for DataBase
    func getGuardInfoData(memberNo: Int){
        Communicator.shared.getGuardInfo(memberNo: memberNo) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                // success
                let lastName = content["lastName"] as! String
                let firstName = content["firstName"] as! String
                let phone = content["phone"] as! String
                
                self.guareNameLabel.text = "\(lastName)"+" "+"\(firstName)"
                self.guarePhoneLabel.text = "\(phone)"
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    //    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    //        return true
    //    }
    
}




