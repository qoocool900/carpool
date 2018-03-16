//
//  SettingViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/2.
//

//////////Test///////////

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var basicContainer: UIView!
    @IBOutlet weak var driveContainer: UIView!
    @IBOutlet weak var guardContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicContainer.isHidden = false
        driveContainer.isHidden = true
        guardContainer.isHidden = true

    }

    @IBAction func logoutBtnPressed(_ sender: Any) {
        self.dismiss(animated: false, completion:nil)
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
