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
    var loginMemberNo = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMemberInfo(memberNo: loginMemberNo)
        let image = showQRcode(memberNo: loginMemberNo, qrCodeImageView: qrCodeImageView)
        qrCodeImageView.image = image
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
    
//MARK: - Show QRcode
    func showQRcode(memberNo: Int, qrCodeImageView: UIImageView) -> UIImage {
        let data = String(memberNo).data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        let qrcodeCIImage = filter?.outputImage
        
        let scaleX = qrCodeImageView.frame.size.width / (qrcodeCIImage?.extent.size.width)!
        let scaleY = qrCodeImageView.frame.size.height / (qrcodeCIImage?.extent.size.height)!
        
        let transformedImage = qrcodeCIImage?.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        //Convert CIImage to UIImage
        let context = CIContext.init(options: nil)
        let cgImage = context.createCGImage(transformedImage!, from: (transformedImage?.extent)!)!
        let qrCodeUIImage:UIImage = UIImage.init(cgImage: cgImage)
        return qrCodeUIImage
    }
    
//MARK: -Link to DataBase    
    // Get MemberInfo From DataBase
    func getMemberInfo(memberNo: Int){
        Communicator.shared.getMemberInfo(memberNo: memberNo) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            
            // success
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                let lastName = content["lastName"] as! String
                let firstName = content["firstName"] as! String
                let phone = content["phone"] as! String
                let gender = content["sex"] as! String
                
                self.lastNameTextField.text = lastName
                self.firstNameTextField.text = firstName
                self.phoneTextField.text = phone
                self.gander = gender
                self.checkGander(gander: self.gander)
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    //Modify MemberInfo to DataBase
    func modifyMemberInfo(memberNo: Int){
        let member = Member()
        member.memberNo = memberNo
        member.firstName = self.firstNameTextField.text!
        member.lastName = self.lastNameTextField.text!
        member.phone = self.phoneTextField.text!
        member.gender = gander
        print("member:\(member)")
        
        Communicator.shared.modifyMemberInfo(member) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                self.showAlert(message: "更新資料成功")
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
}
