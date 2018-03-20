//
//  PassengerNoticeRequestTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/9.
//

import UIKit

class PassengerNoticeRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var carCapacityLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    @IBOutlet weak var requestStatusIng: UIImageView!
    @IBOutlet weak var requestStatusMatch: UIImageView!
    @IBOutlet weak var requestStatusCancel: UIImageView!
    @IBOutlet weak var phoneBtn: UIButton!
    let wait = 0
    let accept = 1
    let refuse = 2
    var requestStatus = 0
    var driverPhone = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkSatus(requestStatus)
        // Configure the view for the selected state
    }
    
    var noticeData: DriverNotice? {
        didSet {
            startLocationLabel.text = noticeData?.startLocation
            endLocationLabel.text = noticeData?.endLocation
            dateLabel.text = noticeData?.date
            carCapacityLabel.text = "\((noticeData?.carCapacity)!)"
            let driverFirstName = (noticeData?.driverFirstName)!
            let driverLastName = (noticeData?.driverLastName)!
            driverNameLabel.text = driverLastName + " " + driverFirstName
            carNumberLabel.text = noticeData?.carNumber
//            requestStatus = "\((noticeData?.requestStatus)!)"
            driverPhone = (noticeData?.driverPhone)!
            checkSatus(requestStatus)
        }
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
        callPhone(phoneNo: driverPhone)
    }
    
    @IBAction func acceptBtnPressed(_ sender: Any) {
        requestStatus = accept
        checkSatus(requestStatus)
    }
    
    @IBAction func refuseBtnPressed(_ sender: Any) {
        requestStatus = refuse
        checkSatus(requestStatus)
    }
    
    func checkSatus(_ requestStatus: Int) {
        switch requestStatus {
        case wait:
            requestStatusIng.image = UIImage(named: "radio_click")
            requestStatusMatch.image = UIImage(named: "radio")
            requestStatusCancel.image = UIImage(named: "radio")
        case accept:
            requestStatusIng.image = UIImage(named: "radio")
            requestStatusMatch.image = UIImage(named: "radio_click")
            requestStatusCancel.image = UIImage(named: "radio")
            
        case refuse:
            requestStatusIng.image = UIImage(named: "radio")
            requestStatusMatch.image = UIImage(named: "radio")
            requestStatusCancel.image = UIImage(named: "radio_click")
            phoneBtn.isEnabled = false
        default:
            break
        }
    }
    
    //    Update Status to Database
    func updateStatus(seqNo: Int, status: Int) {
        Communicator.shared.updateStatus(seqNo: seqNo, status: status) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [[String:Any]]
            let code = response["code"] as! Int
            if code == 0 {
               
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
        
    }
}


