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
    var seqNo = 0
    var tripId = ""
    var driverPhone = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    var noticeData: DriverNotice? {
        didSet {
            seqNo = (noticeData?.seqNo)!
            tripId = (noticeData?.tripId)!
            startLocationLabel.text = noticeData?.startLocation
            endLocationLabel.text = noticeData?.endLocation
            dateLabel.text = noticeData?.date
            carCapacityLabel.text = "\((noticeData?.carCapacity)!)"
            let driverFirstName = (noticeData?.driverFirstName)!
            let driverLastName = (noticeData?.driverLastName)!
            driverNameLabel.text = driverLastName + " " + driverFirstName
            carNumberLabel.text = noticeData?.carNumber
            driverPhone = (noticeData?.driverPhone)!
        }
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
        callPhone(phoneNo: driverPhone)
    }
    
    func checkSatusImage(requestStatus: Int) {
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
}


