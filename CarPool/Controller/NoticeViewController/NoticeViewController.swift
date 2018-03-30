//
//  NoticeViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/2.
//

import UIKit

class NoticeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = UIImage(named: "tab_alarm")?.withRenderingMode(.alwaysOriginal)
        driverContainer.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var driverContainer: UIView!

    @IBOutlet weak var passengerContainer: UIView!
    
    @IBAction func roleChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            passengerContainer.isHidden = false
            driverContainer.isHidden = true
        case 1:
            passengerContainer.isHidden = true
            driverContainer.isHidden = false
        default:
            break
        }
    }   
}
