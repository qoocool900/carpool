//
//  PassengerNoticeReceivedTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class PassengerNoticeReceivedTableViewCell: UITableViewCell {

    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var carCapacityLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    @IBOutlet weak var requestStatusIng: UIImageView!
    @IBOutlet weak var requestStatusMatch: UIImageView!
    @IBOutlet weak var requestStatusCancel: UIImageView!
    @IBOutlet weak var refuseBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    let wait = "0"
    let accept = "1"
    let refuse = "2"
    var requestStatus = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkSatus(requestStatus)
        // Configure the view for the selected state
    }
    
    var noticeData: Notice? {
        didSet {
            startLocationLabel.text = noticeData?.startLocation
            endLocationLabel.text = noticeData?.endLocation
            dateLabel.text = noticeData?.date
            carCapacityLabel.text = noticeData?.carCapacity
            driverNameLabel.text = noticeData?.driverName
            carNumberLabel.text = noticeData?.carNumber
            requestStatus = (noticeData?.requestStatus)!
            checkSatus(requestStatus)
        }
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func acceptBtnPressed(_ sender: Any) {
        requestStatus = accept
        checkSatus(requestStatus)
    }
    
    @IBAction func refuseBtnPressed(_ sender: Any) {
        requestStatus = refuse
        checkSatus(requestStatus)
    }
    
    func checkSatus(_ requestStatus: String) {
        switch requestStatus {
        case wait:
            requestStatusIng.image = UIImage(named: "radio_click")
            requestStatusMatch.image = UIImage(named: "radio")
            requestStatusCancel.image = UIImage(named: "radio")
        case accept:
            requestStatusIng.image = UIImage(named: "radio")
            requestStatusMatch.image = UIImage(named: "radio_click")
            requestStatusCancel.image = UIImage(named: "radio")
            acceptBtn.isHidden = true
            refuseBtn.isHidden = true

        case refuse:
            requestStatusIng.image = UIImage(named: "radio")
            requestStatusMatch.image = UIImage(named: "radio")
            requestStatusCancel.image = UIImage(named: "radio_click")
            acceptBtn.isHidden = true
            refuseBtn.isHidden = true
            phoneBtn.isEnabled = false
        default:
            break
        }
    }

}

