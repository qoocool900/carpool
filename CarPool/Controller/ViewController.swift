//
//  ViewController.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/2.
//

import UIKit

class ViewController: UIViewController {
    
    
    var member = Member()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Communicator.shared.checkUser(mail: "a", password: "a") { (error, result) in
            if let error = error {
                NSLog("checkUser fail: \(error)")
//                let msg = result!["msg"] as? String
                return
            }
            // success
            print(result!)
            guard let memberNo = result!["memberNo"] as? Int else {
                return
            }
            
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

