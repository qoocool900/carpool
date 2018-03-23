//
//  DriverRecordTableViewCell.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit

class DriverRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var startLocationLabel: UILabel!
    @IBOutlet weak var endLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var driverTripId: String = ""
    var seqNo: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var recordData: DriverRecord? {
        didSet {
            driverTripId = (recordData?.driverTripId)!
            startLocationLabel.text = recordData?.startLocation
            endLocationLabel.text = recordData?.endLocation
            dateLabel.text = recordData?.date
        }
    }
}

