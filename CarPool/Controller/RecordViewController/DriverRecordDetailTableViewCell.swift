//
//  DriverRecordDetailTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class DriverRecordDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var passengerNameLabel: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var onTimeLabel: UILabel!
    @IBOutlet weak var offTimeLabel: UILabel!
    var passengerPhone = ""
    var passengerTripId: String = ""
    var seqNo: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var recordData: DriverRecordDetail? {
        didSet {
            startLocationLabel.text = recordData?.startLocation
            endLocationLabel.text = recordData?.endLocation
            let passengerFirstName = (recordData?.passengerFirstName)!
            let passengerLastName = (recordData?.passengerLastName)!
            passengerNameLabel.text = passengerLastName + " " + passengerFirstName
            onTimeLabel.text = recordData?.onTime
            offTimeLabel.text = recordData?.offTime
            passengerPhone = (recordData?.passengerPhone)!
        }
    }
    @IBAction func phoneBtnPressed(_ sender: Any) {
        callPhone(phoneNo: passengerPhone)
    }
}

