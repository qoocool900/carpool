//
//  DriverNoticeRequestTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/9.
//

import UIKit

class DriverNoticeRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var passengerCountLabel: UILabel!
    @IBOutlet weak var passengerNameLabel: UILabel!
    @IBOutlet weak var requestStatusWait: UIImageView!
    @IBOutlet weak var requestStatusAccept: UIImageView!
    @IBOutlet weak var requestStatusRefuse: UIImageView!
    @IBOutlet weak var phoneBtn: UIButton!
    let wait = 0
    let accept = 1
    let refuse = 2
    var tripId = ""
    var requestStatus = 0
    var passengerPhone = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkSatus(requestStatus)
        // Configure the view for the selected state
    }
    
    var noticeData: PassengerNotice? {
        didSet {
            startLocationLabel.text = noticeData?.startLocation
            endLocationLabel.text = noticeData?.endLocation
            dateLabel.text = noticeData?.date
            let passengerFirstName = (noticeData?.passengerFirstName)!
            let passengerLastName = (noticeData?.passengerLastName)!
            passengerCountLabel.text = "\((noticeData?.passengerCount)!)"
            passengerNameLabel.text = passengerLastName + " " + passengerFirstName
            passengerPhone = (noticeData?.passengerPhone)!
            checkSatus(requestStatus)
        }
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
      callPhone(phoneNo: passengerPhone)
    }
    
    func checkSatus(_ requestStatus: Int) {
        switch requestStatus {
        case wait:
            requestStatusWait.image = UIImage(named: "radio_click")
            requestStatusAccept.image = UIImage(named: "radio")
            requestStatusRefuse.image = UIImage(named: "radio")
        case accept:
            requestStatusWait.image = UIImage(named: "radio")
            requestStatusAccept.image = UIImage(named: "radio_click")
            requestStatusRefuse.image = UIImage(named: "radio")
        case refuse:
            requestStatusWait.image = UIImage(named: "radio")
            requestStatusAccept.image = UIImage(named: "radio")
            requestStatusRefuse.image = UIImage(named: "radio_click")
            phoneBtn.isEnabled = false
        default:
            break
        }
    }
}
