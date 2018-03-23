//
//  RecordTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/7.
//

import UIKit

class PassengerRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    @IBOutlet weak var onTimeLabel: UILabel!
    @IBOutlet weak var offTimeLabel: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var evluationBtn: UIButton!
    var driverMemberNo = 0
    var driverPhone = ""
    var driverTripId = ""
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var recordData: PassengerRecord? {
        didSet {
            startLocationLabel.text = recordData?.pStartLocation
            endLocationLabel.text = recordData?.pEndLocation
            carNumberLabel.text = recordData?.carNumber
            
            let firstName = (recordData?.driverFirstName)!
            let lastName = (recordData?.driverLastName)!
            driverNameLabel.text = firstName + " " + lastName
            
            dateLabel.text = recordData?.date
            onTimeLabel.text = recordData?.onTime
            offTimeLabel.text = recordData?.offTime
            
            driverMemberNo = (recordData?.driverMemberNo)!
            driverPhone = (recordData?.driverPhone)!
            driverTripId = (recordData?.driverTripId)!
        }
    }
    @IBAction func phoneBtnPressed(_ sender: Any) {
       callPhone(phoneNo: driverPhone)
    }
}
