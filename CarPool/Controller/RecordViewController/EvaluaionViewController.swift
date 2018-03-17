//
//  EvaluaionViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/12.
//

import UIKit

class EvaluaionViewController: UIViewController {

    @IBOutlet weak var scoreDriver1Btn: UIButton!
    @IBOutlet weak var scoreDriver2Btn: UIButton!
    @IBOutlet weak var scoreDriver3Btn: UIButton!
    @IBOutlet weak var scoreDriver4Btn: UIButton!
    @IBOutlet weak var scoreDriver5Btn: UIButton!
    @IBOutlet weak var scoreSafty1Btn: UIButton!
    @IBOutlet weak var scoreSafty2Btn: UIButton!
    @IBOutlet weak var scoreSafty3Btn: UIButton!
    @IBOutlet weak var scoreSafty4Btn: UIButton!
    @IBOutlet weak var scoreSafty5Btn: UIButton!
    @IBOutlet weak var scoreComfort1Btn: UIButton!
    @IBOutlet weak var scoreComfort2Btn: UIButton!
    @IBOutlet weak var scoreComfort3Btn: UIButton!
    @IBOutlet weak var scoreComfort4Btn: UIButton!
    @IBOutlet weak var scoreComfort5Btn: UIButton!
    
    let loginMemberNo = 3
    var driverMemberNo: Int = 0
    var driverTripId: String = ""
    
    var scoreDriver: Float = 0.0
    var scoreSafty: Float = 0.0
    var scoreComfort: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
//        let blurEffect = UIBlurEffect(style: .extraLight)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        backImageView.addSubview(blurEffectView)
    }
        
    @IBAction func scoreDriver1BtnPressed(_ sender: Any) {
        scoreDriver = 1.0
        scoreDriver1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver2Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreDriver3Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreDriver4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreDriver5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    
    @IBAction func scoreDriver2BtnPressed(_ sender: Any) {
        scoreDriver = 2.0
        scoreDriver1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver3Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreDriver4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreDriver5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreDriver3BtnPressed(_ sender: Any) {
        scoreDriver = 3.0
        scoreDriver1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreDriver5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreDriver4BtnPressed(_ sender: Any) {
        scoreDriver = 4.0
        scoreDriver1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver4Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreDriver5BtnPressed(_ sender: Any) {
        scoreDriver = 5.0
        scoreDriver1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver4Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreDriver5Btn.setImage(UIImage(named:"star"), for: .normal)
    }
    
    
    
    @IBAction func scoreSafty1BtnPressed(_ sender: Any) {
        scoreSafty = 1.0
        scoreSafty1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty2Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreSafty3Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreSafty4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreSafty5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreSafty2BtnPressed(_ sender: Any) {
        scoreSafty = 2.0
        scoreSafty1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty3Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreSafty4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreSafty5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreSafty3BtnPressed(_ sender: Any) {
         scoreSafty = 3.0
        scoreSafty1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreSafty5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreSafty4BtnPressed(_ sender: Any) {
        scoreSafty = 4.0
        scoreSafty1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty4Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreSafty5BtnPressed(_ sender: Any) {
        scoreSafty = 5.0
        scoreSafty1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty4Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreSafty5Btn.setImage(UIImage(named:"star"), for: .normal)
    }
    
    
    
    @IBAction func scoreComfort1BtnPressed(_ sender: Any) {
        scoreComfort = 1.0
        scoreComfort1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort2Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreComfort3Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreComfort4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreComfort5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreComfort2BtnPressed(_ sender: Any) {
        scoreComfort = 2.0
        scoreComfort1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort3Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreComfort4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreComfort5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreComfort3BtnPressed(_ sender: Any) {
        scoreComfort = 3.0
        scoreComfort1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort4Btn.setImage(UIImage(named:"star_blank"), for: .normal)
        scoreComfort5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreComfort4BtnPressed(_ sender: Any) {
        scoreComfort = 4.0
        scoreComfort1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort4Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort5Btn.setImage(UIImage(named:"star_blank"), for: .normal)
    }
    @IBAction func scoreComfort5BtnPressed(_ sender: Any) {
        scoreComfort = 5.0
        scoreComfort1Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort2Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort3Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort4Btn.setImage(UIImage(named:"star"), for: .normal)
        scoreComfort5Btn.setImage(UIImage(named:"star"), for: .normal)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        addEvaluation(loginMemberNo: loginMemberNo, driverMemberNo: driverMemberNo)
        print("driverMemberNo: \(driverMemberNo),driverTripId:\(driverTripId)")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    func addEvaluation(tripId:String, memberNo:Int, driverMemberNo:Int, scoreDriver:Float, scoreSafe:Float, scoreComfort:Float, doneHandler:@escaping DoneHandler) {
//        let parameters: [String : Any] = [ACTION:"addEvaluation", "tripID":tripId, "memberNo":memberNo, "driverMemberNo":driverMemberNo, "scoreDriver":scoreDriver, "scoreSafe":scoreSafe, "scoreComfort":scoreComfort]
//        doPost(urlString: RECORD_URL, parameters: parameters, doneHandler: doneHandler)
//    }
    
//MARK: -AddEvaluation to DataBase
    func addEvaluation(loginMemberNo: Int, driverMemberNo: Int){
        print("Evluation Data - tripId: \(driverTripId), memberNo: \(loginMemberNo), driverMemberNo: \(driverMemberNo), scoreDriver: \(scoreDriver), scoreSafe: \(scoreSafty), scoreComfort: \(scoreComfort)")
        
        Communicator.shared.addEvaluation(tripId: driverTripId, memberNo: loginMemberNo, driverMemberNo: driverMemberNo, scoreDriver: scoreDriver, scoreSafe: scoreSafty, scoreComfort: scoreComfort, doneHandler: { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                self.showAlert(message: "評價成功")
            }
            let msg = response ["msg"] as! String
            print(msg)
        })
    }
}
