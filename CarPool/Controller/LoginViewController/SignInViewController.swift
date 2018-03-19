//
//  SignInViewController.swift
//
//
//  Created by 胡靜諭 on 2018/3/8.
//
// SignIn
import UIKit
import TransitionButton

class SignInViewController: UIViewController,UITextFieldDelegate{
    
    
    @IBOutlet weak var FirstName: UITextField!
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var EmailText: UITextField!
    
    @IBOutlet weak var PhoneText: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var Gender: UITextField!
    
    
    @IBAction func SaveMemberInfoButton(_ sender: Any) {
        
        // 其實這邊也是像andriod那邊一樣 一個值一個值放
        let member = Member()
        
        // 先判斷輸入是否為空直, 不是的話把user key 的東西記下來 放到member裡面對應的參數
        guard FirstName.text != "" else{
            return
        }
        guard LastName.text  != "" else{
            return
        }
        guard EmailText.text != "" else{
            return
        }
        guard PhoneText.text != "" else {
            return
        }
        guard Password.text != "" else {
            return
        }
        guard Gender.text != "" else {
            return
        }
        
        member.firstName = FirstName.text!
        // 這邊就不示範判斷輸入是否為空值 可仿照上面 或是自己的寫法
        member.lastName = LastName.text!
        member.mail = EmailText.text!
        member.phone = PhoneText.text!
        member.password = Password.text!
        //member.gender = Gender.text!
        
        // 最後把剛剛那個member丟到 doRegister
        Communicator.shared.doRegister(member) { (error, result) in
            if let error = error {
                NSLog("doRegister fail: \(error)")
                return
            }
            // success
            self.showAlert(message: "註冊成功")
            NSLog("doRegister ok")
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstName.placeholder = "名字"
        FirstName.font = UIFont(name: "System", size: 30)
        
        LastName.placeholder = "姓名"
        LastName.font = UIFont(name: "System", size: 30)
        
        EmailText.placeholder = "Email"
        EmailText.font = UIFont(name: "System", size: 30)
        
        PhoneText.placeholder = "電話"
        PhoneText.font = UIFont(name: "System", size: 30)
        
        Password.placeholder = "密碼"
        Password.font = UIFont(name: "System", size: 30)
        
        Gender.placeholder = "男性輸入入M，女性輸入Ｆ"
        Gender.font = UIFont(name: "System", size: 20)
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
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


