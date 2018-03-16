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

    var loginMemberNo = 1
    var scanMemberNo = 1
    var scanMemberName = ""
    var scanMemberPhone = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guareNameLabel.text = scanMemberName
        guarePhoneLabel.text = scanMemberPhone
        getGuardInfoData(memberNo: loginMemberNo)
        
    }
    
    @IBAction func phonePressed(_ sender: Any) {
        print("name = \(name)")
    }
    @IBAction func savePressed(_ sender: Any) {
        Communicator.shared.modifyGuardInfo(memberNo: loginMemberNo, guardMemberNo: scanMemberNo, doneHandler: { (error, result) in
            if let error = error {
                NSLog("Modify guard information fail: \(error)")
                return
            }
            // success
            print("Modify guard information success!")
        })
    }
    
    // Get GuardData already been set for DataBase
    func getGuardInfoData(memberNo: Int){
        Communicator.shared.getGuardInfo(memberNo: memberNo) { (error, result) in
            if let error = error {
                NSLog("Check gurad  information fail: \(error)")
                return
            }
            // success
            print(result!)
            guard let lastName = result!["lastName"] as? String else {
                return
            }
            guard let firstName = result!["firstName"] as? String else {
                return
            }
            guard let phone = result!["phone"] as? String else {
                return
            }
            print(phone)
    
            self.guareNameLabel.text = lastName + firstName
            self.guarePhoneLabel.text = "\(phone)"
            self.name = lastName + firstName
            print("123"+self.name)
        }
    }
    
    // Get MemberIno From DataBase
    func getMemberInfo(memberNo: Int) -> [String:String]{
        var memberInfo:[String:String] = [:]
        Communicator.shared.getMemberInfo(memberNo: memberNo) { (error, result) in
            if let error = error {
                NSLog("Check member information fail: \(error)")
                return
            }
            // success
            print(result!)
            guard let lastName = result!["lastName"] as? String else {
                return
            }
            guard let firstName = result!["firstName"] as? String else {
                return
            }
            guard let phone = result!["phone"] as? String else {
                return
            }
            memberInfo = ["lastName": lastName,"firstName":firstName,"phone":phone]
            print(memberInfo)
        }
        return memberInfo
    }
    
}
