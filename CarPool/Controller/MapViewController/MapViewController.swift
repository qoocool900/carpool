//
//  MapViewController.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/2.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var carAndPeopleContaninerView: UIView!
    @IBOutlet weak var GuardContainerView: UIView!

    var myMapViewController:MyMapViewController?
    var guardViewController:GuardViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GuardContainerView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func roleChanged(_ sender: UISegmentedControl) {
        // 創造出新的有UI的ViewController
//        let VCM = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "MyMapViewController") as! MyMapViewController

        // 創造出新的沒有UI的ViewController
//        let mmvc = MyMapViewController()
        
        switch sender.selectedSegmentIndex {
        case 0:
            carAndPeopleContaninerView.isHidden = false
            GuardContainerView.isHidden = true
            myMapViewController?.role = 0
        case 1:
            carAndPeopleContaninerView.isHidden = false
            GuardContainerView.isHidden = true
            myMapViewController?.role = 1
        case 2:
            carAndPeopleContaninerView.isHidden = true
            GuardContainerView.isHidden = false
        default:
            break
        }
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? MyMapViewController {
            myMapViewController = vc
        } else if let vc = segue.destination as? GuardViewController {
            guardViewController = vc
        }
        
    }
    

}
