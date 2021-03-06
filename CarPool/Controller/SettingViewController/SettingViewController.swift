//
//  SettingViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/2.
//

import UIKit
import FBSDKLoginKit

class SettingViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var basicContainer: UIView!
    @IBOutlet weak var driveContainer: UIView!
    @IBOutlet weak var guardContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = UIImage(named: "tab_setting")?.withRenderingMode(.alwaysOriginal)
        basicContainer.isHidden = false
        driveContainer.isHidden = true
        guardContainer.isHidden = true
    }
  
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
//        defaults.removeObject(forKey: "memberNo")
        defaults.set(0, forKey: "memberNo")
        defaults.set("", forKey: "memberNo")
        defaults.synchronize()
        print(defaults.integer(forKey: "memberNo"))
        FBSDKLoginManager().logOut()
        print("Logout")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController = controller
    }
       
    @IBAction func roleChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            basicContainer.isHidden = false
            driveContainer.isHidden = true
            guardContainer.isHidden = true
        case 1:
            basicContainer.isHidden = true
            driveContainer.isHidden = false
            guardContainer.isHidden = true
        case 2:
            basicContainer.isHidden = true
            driveContainer.isHidden = true
            guardContainer.isHidden = false
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
