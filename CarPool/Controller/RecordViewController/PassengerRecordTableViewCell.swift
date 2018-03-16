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
    var driverPhone = ""
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var recordData: PassengerRecord? {
        didSet {
            startLocationLabel.text = recordData?.startLocation
            endLocationLabel.text = recordData?.endLocation
            dateLabel.text = recordData?.date
            driverNameLabel.text = recordData?.driverName
            carNumberLabel.text = recordData?.carNumber
            driverPhone = (recordData?.driverPhone)!
        }
    }
    
    @IBAction func phoneBtnPressed(_ sender: Any) {
        callPhone(phoneNo: driverPhone)
    }
    
    @IBAction func evluationBtnPressed(_ sender: Any) {

    }
}
