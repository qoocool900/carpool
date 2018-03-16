

import UIKit
import FBSDKLoginKit
import TransitionButton



class LoginViewController:UIViewController,FBSDKLoginButtonDelegate,UITextViewDelegate {
    

    @IBOutlet weak var UserMailTextField: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
  
    
    @IBAction func MemberLogin(_ button: TransitionButton) {
        
        
    
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
    
    func get_firstName() -> String{
        let getFirstName = UserDefaults.standard.string(forKey: "firstName")
        //判断UserDefaults中是否已经存在
        if(getFirstName != nil){
            return getFirstName!
        }else{
            //不存在则生成一个新的并保存
            let getFirstName_ref = CFUUIDCreate(nil)
            let getFirstName_string_ref = CFUUIDCreateString(nil , getFirstName_ref)
            let getFirstName = getFirstName_string_ref! as String
            UserDefaults.standard.set(getFirstName, forKey: "firstName")
            return getFirstName
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
//                    let defaults = UserDefaults.standard
//                    defaults.set(String(describing: resultNew["first_name"]), forKey: "first_name")
//                                        defaults.synchronize()
//                                        print(defaults.set(firstName, forKey: "first_name"))
                
                    
                    let lastName = resultNew["last_name"] as! String
                    print(lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url) //臉書大頭貼的url, 再放入imageView內秀出來
                        
                        
                       
                    
                    }
                    
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

