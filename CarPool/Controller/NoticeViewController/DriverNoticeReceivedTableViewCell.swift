//
//  DriverNoticeReceivedTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/9.
//

import UIKit

class DriverNoticeReceivedTableViewCell: UITableViewCell {


    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var passengerCountLabel: UILabel!
    @IBOutlet weak var passengerNameLabel: UILabel!
    @IBOutlet weak var requestStatusWait: UIImageView!
    @IBOutlet weak var requestStatusAccept: UIImageView!
    @IBOutlet weak var requestStatusRefuse: UIImageView!
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
            passengerCountLabel.text = noticeData?.passengerCount
            passengerNameLabel.text = noticeData?.passengerName
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
            requestStatusWait.image = UIImage(named: "radio_click")
            requestStatusAccept.image = UIImage(named: "radio")
            requestStatusRefuse.image = UIImage(named: "radio")
        case accept:
            requestStatusWait.image = UIImage(named: "radio")
            requestStatusAccept.image = UIImage(named: "radio_click")
            requestStatusRefuse.image = UIImage(named: "radio")
            acceptBtn.isHidden = true
            refuseBtn.isHidden = true
        case refuse:
            requestStatusWait.image = UIImage(named: "radio")
            requestStatusAccept.image = UIImage(named: "radio")
            requestStatusRefuse.image = UIImage(named: "radio_click")
            acceptBtn.isHidden = true
            refuseBtn.isHidden = true
            phoneBtn.isEnabled = false
        default:
            break
        }
    }
    
}


