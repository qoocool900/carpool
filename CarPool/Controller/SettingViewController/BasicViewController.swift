//
//  BasicViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/6.
//

import UIKit

class BasicViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    var qrcodeCIImage: CIImage!
    var gander: String = ""
    var loginMemberNo = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMemberInfo(memberNo: loginMemberNo)
        checkGander(gander: gander)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        modifyMemberInfo(memberNo: loginMemberNo)
    }
    
//MARK: - Gander
    func checkGander(gander:String){
        switch gander {
        case "M":
            maleBtn.setImage(UIImage(named:"radio_click"), for: .normal)
            femaleBtn.setImage(UIImage(named:"radio"), for: .normal)
            headImageView.image = UIImage(named: "boy")
        case "F":
            maleBtn.setImage(UIImage(named:"radio"), for: .normal)
            femaleBtn.setImage(UIImage(named:"radio_click"), for: .normal)
            headImageView.image = UIImage(named: "girl")
        default:
            maleBtn.setImage(UIImage(named:"radio_click"), for: .normal)
            femaleBtn.setImage(UIImage(named:"radio"), for: .normal)
            headImageView.image = UIImage(named: "boy")
        }
    }
    
    @IBAction func maleBtnPressed(_ sender: Any) {
        gander = "M"
        checkGander(gander: gander)
    }
    
    @IBAction func femaleBtnPressed(_ sender: Any) {
        gander = "F"
        checkGander(gander: gander)
    }
  
//MARK: -Keybord Setting
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
//MARK: -Link to DataBase
    
    // Get MemberInfo From DataBase
    func getMemberInfo(memberNo: Int){
        Communicator.shared.getMemberInfo(memberNo: 3) { (error, result) in
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
            
            guard let sex = result!["sex"] as? String else {
                return
            }
        
            self.lastNameTextField.text = lastName
            self.firstNameTextField.text = firstName
            self.phoneTextField.text = phone
            self.gander = sex
            self.checkGander(gander: self.gander)
        }
    }
    
//     Modify MemberInfo to DataBase
    func modifyMemberInfo(memberNo: Int){
        let member = Member()
        member.memberNo = 3
        member.firstName = self.firstNameTextField.text!
        member.lastName = self.lastNameTextField.text!
        member.phone = self.phoneTextField.text!
        member.gender = gander
        print("member:\(member)")
        
        Communicator.shared.modifyMemberInfo(member) { (error, result) in
            if let error = error {
                NSLog("Modify member information fail: \(error)")
                return
            }
            // success
            print(result!)
            print("Modify member information success!")
        }
    }
}
