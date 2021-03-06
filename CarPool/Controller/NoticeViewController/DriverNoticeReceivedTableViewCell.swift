//
//  DriverNoticeReceivedTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/9.
//

import UIKit

protocol DriverReceivedCellDelegate {
    func updateReceivedAcceptStatus(Cell: UITableViewCell,reqNo: Int, status: Int, tripId: String)
    func updateReceivedRefuseStatus(Cell: UITableViewCell,reqNo: Int, status: Int, tripId: String)
}

class DriverNoticeReceivedTableViewCell: UITableViewCell {

    var delegate: DriverReceivedCellDelegate?
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var passengerCountLabel: UILabel!
    @IBOutlet weak var passengerNameLabel: UILabel!
    @IBOutlet weak var requestStatusIng: UIImageView!
    @IBOutlet weak var requestStatusMatch: UIImageView!
    @IBOutlet weak var requestStatusCancel: UIImageView!
    @IBOutlet weak var refuseBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    let wait = 0
    let accept = 1
    let refuse = 2
    var seqNo = 0
    var tripId = ""
    var passengerPhone = ""
    var status = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    var noticeData: PassengerNotice? {
        didSet {
            seqNo = (noticeData?.seqNo)!
            tripId = (noticeData?.tripId)!
            startLocationLabel.text = noticeData?.startLocation
            endLocationLabel.text = noticeData?.endLocation
            dateLabel.text = noticeData?.date
            let passengerFirstName = (noticeData?.passengerFirstName)!
            let passengerLastName = (noticeData?.passengerLastName)!
            passengerCountLabel.text = "\((noticeData?.passengerCount)!)"
            passengerNameLabel.text = passengerLastName + " " + passengerFirstName
            passengerPhone = (noticeData?.passengerPhone)!
            status = (noticeData?.status)!
            checkSatusImage(requestStatus: status)
        }
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
      callPhone(phoneNo: passengerPhone)
    }
    
    @IBAction func acceptBtnPressed(sender: Any) {
        delegate?.updateReceivedAcceptStatus(Cell:self,reqNo: seqNo, status: accept, tripId: tripId)
        checkSatusImage(requestStatus: accept)
    }
    
    @IBAction func refuseBtnPressed(_ sender: Any) {
        delegate?.updateReceivedRefuseStatus(Cell:self,reqNo: seqNo, status: refuse, tripId: tripId)
        checkSatusImage(requestStatus: refuse)
    }
    
    func checkSatusImage(requestStatus: Int) {
        switch requestStatus {
        case wait:
            requestStatusIng.image = UIImage(named: "radio_click")
            requestStatusMatch.image = UIImage(named: "radio")
            requestStatusCancel.image = UIImage(named: "radio")
            acceptBtn.isHidden = false
            refuseBtn.isHidden = false
            phoneBtn.isEnabled = true
        case accept:
            requestStatusIng.image = UIImage(named: "radio")
            requestStatusMatch.image = UIImage(named: "radio_click")
            requestStatusCancel.image = UIImage(named: "radio")
            acceptBtn.isHidden = true
            refuseBtn.isHidden = true
            phoneBtn.isEnabled = true
            
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


