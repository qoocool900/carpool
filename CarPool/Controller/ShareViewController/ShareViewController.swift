//
//  ShareViewController.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/2.
//

import UIKit

class ShareViewController: UIViewController {
    
    
    @IBOutlet weak var DriverSetup: UIView!
    
    @IBOutlet weak var PassengerSetup: UIView!
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            DriverSetup.isHidden = false
            PassengerSetup.isHidden = true
            
        case 1:
            DriverSetup.isHidden = true
            PassengerSetup.isHidden = false
        default:
            break;
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PassengerSetup.isHidden = true
        // Do any additional setup after loading the view.
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

