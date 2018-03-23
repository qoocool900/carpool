

import UIKit
import FBSDKLoginKit
import TransitionButton



class LoginViewController:UIViewController,FBSDKLoginButtonDelegate,UITextViewDelegate {
    
    @IBOutlet weak var UserMailTextField: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBAction func MemberLogin(_ button: TransitionButton) {
        //let text =
        
        guard (UserMailTextField.text != "") && (PasswordText.text != "") else {
            print("沒輸入email and password")
            showAlert(message: "沒輸入email and password")
            return
        }
        
        Communicator.shared.checkUser(mail: UserMailTextField.text!, password: PasswordText.text!) { (error, result) in
            if let error = error {
                NSLog("Login fail: \(error)")
                //let msg = result!["msg"] as! String
                self.showAlert(message: "伺服器連線失敗")
                return
            }
            // success
            // Prepare Userdefault for MemberNo
            let content = result!["content"] as![String:Any]
            let memberNo = content["memberNo"] as? Int
            let defaults = UserDefaults.standard
            defaults.set(memberNo, forKey: "memberNo")
            defaults.synchronize()
            print(defaults.integer(forKey: "memberNo"))
            // print(56778)
            
            let response = result!["response"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                
                button.startAnimation() // 2: Then start the animation when the user tap the button
                let qualityOfServiceClass = DispatchQoS.QoSClass.background
                let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                
                backgroundQueue.async(execute: {
                    
                    sleep(3) // 3: Do your networking task or background work here.'
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        button.stopAnimation(animationStyle: .expand, completion: {
                            
                        })
                        let storyboard = UIStoryboard(name: "Map", bundle: nil)
                        let controller = storyboard.instantiateInitialViewController()
                        self.view.window?.rootViewController = controller
                    })
                })
            }
            let msg = response["msg"] as? String
            print(msg)
            self.showAlert(message:(msg)!)
        }
    }
    
    
    @IBOutlet weak var faceBookLogIn: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UserMailTextField.placeholder = "Email"
        UserMailTextField.font = UIFont(name: "System", size: 25)
        PasswordText.placeholder = "password"
        PasswordText.font = UIFont(name: "System", size: 25)
        
        faceBookLogIn.readPermissions = ["public_profile", "email", "user_friends"]
        faceBookLogIn.delegate = self
        
        //        第一次登入後可取得使用者token，後續即可直接登入
        if (FBSDKAccessToken.current()) != nil{
            fetchProfile()
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("didCompleteWith", error, Thread.isMainThread)
        fetchProfile()
    }
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func getFirstName() -> String{
        let getFirstName = UserDefaults.standard.string(forKey: "first_name")
        //判断UserDefaults中是否已经存在
        if(getFirstName != nil){
            return getFirstName!
        }else{
            let getFirstName_ref = CFUUIDCreate(nil)
            let getFirstName_string_ref = CFUUIDCreateString(nil , getFirstName_ref)
            let getFirstName = getFirstName_string_ref! as String
            UserDefaults.standard.set(getFirstName, forKey: "first_name")
            return getFirstName
        }
    }
    
    func getLastName() -> String{
        let getLastName = UserDefaults.standard.string(forKey: "last_name")
        //判断UserDefaults中是否已经存在
        if(getLastName != nil){
            return getLastName!
        }else{
            let getLastName_ref = CFUUIDCreate(nil)
            let getLastName_string_ref = CFUUIDCreateString(nil , getLastName_ref)
            let getLastName = getLastName_string_ref! as String
            UserDefaults.standard.set(getLastName, forKey: "last_Name")
            return getLastName
        }
    }
    
    func getMemberNo() -> Int{
        let getMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
        if(getMemberNo != nil){
            return getMemberNo
        }else{
            let getMemberNo_ref = CFUUIDCreate(nil)
            let getMemberNo_int_ref = CFUUIDCreateString(nil , getMemberNo_ref)
            let getMemberNo = getMemberNo_int_ref! as! Int
            UserDefaults.standard.set(getMemberNo, forKey: "memberNo")
            return getMemberNo
        }
    }
    
    
    
    func fetchProfile() {
        print("attempt to fetch profile......")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("登入失敗")
                print("longinerror =\(error)")
            } else {
                
                
                if let resultNew = result as? [String:Any]{
                    
                    print("成功登入")
                    
                    let email = resultNew["email"]  as! String
                    print(email)
                    
                    let firstName = resultNew["first_name"] as! String
                    print(firstName)
                    let defaults = UserDefaults.standard
                    defaults.set(String(describing: resultNew["first_name"]), forKey: "first_name")
                    defaults.synchronize()
                    print(defaults.string(forKey: "first_name"))
                    
                    let lastName = resultNew["last_name"] as! String
                    print(lastName)
                    
                    let fbMember = Member()
                    fbMember.firstName = firstName
                    fbMember.lastName = lastName
                    fbMember.mail = email
                    
                    Communicator.shared.doRegister(fbMember, doneHandler: { (error,result ) in
                        if let error = error {
                            
                            NSLog("FbRegister Fail: \(error)")
                            
                            return
                        }
                        NSLog("doFBRegister ok")
                        
                    })
                    //                    Communicator.shared.checkUser(fbMember.email: "0", fbMember.firstName: "a") { (error, result) in
                    //                        if let error = error {
                    //                            NSLog("checkUser fail: \(error)")
                    //                            let msg = result!["msg"] as? String
                    //                            return
                    //                        }
                    //                        // success
                    //                        print(result!)
                    //                        guard let memberNo = result!["memberNo"] as? Int else {
                    //                            return
                    //                        }
                    //                        guard let memberName = result!["memberNo"] as? Int else {
                    //                            return
                    //                        }
                    
                    
                }
                // show main page
                
                print("show main page", Thread.isMainThread)
                let storyboard = UIStoryboard(name: "Map", bundle: nil)
                let controller = storyboard.instantiateInitialViewController()
                self.view.window?.rootViewController = controller
                
            }
            
        })
    }
}

extension UITextView: UITextViewDelegate {
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLbl = self.viewWithTag(50) as? UILabel {
                placeholderText = placeholderLbl.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLbl = self.viewWithTag(50) as! UILabel? {
                placeholderLbl.text = newValue
                placeholderLbl.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLbl = self.viewWithTag(50) as? UILabel {
            placeholderLbl.isHidden = self.text.characters.count > 0
        }
    }
    
    private func resizePlaceholder() {
        if let placeholderLbl = self.viewWithTag(50) as! UILabel? {
            let x = self.textContainer.lineFragmentPadding
            let y = self.textContainerInset.top - 2
            let width = self.frame.width - (x * 2)
            let height = placeholderLbl.frame.height
            
            placeholderLbl.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLbl = UILabel()
        
        placeholderLbl.text = placeholderText
        placeholderLbl.sizeToFit()
        
        placeholderLbl.font = self.font
        placeholderLbl.textColor = UIColor.lightGray
        placeholderLbl.tag = 50
        
        placeholderLbl.isHidden = self.text.characters.count > 0
        
        self.addSubview(placeholderLbl)
        self.resizePlaceholder()
        self.delegate = self
    }
}
extension UITextView {
    func decreaseFontSize () {
        self.font =  UIFont(name: self.font!.fontName, size: self.font!.pointSize-10)!
    }
    
    
}

//


