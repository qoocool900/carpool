//
//  DRecordingTableViewCell.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/16.
//

import UIKit

class DRecordingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var driverBoarding: UILabel!
    
    @IBOutlet weak var driverDestination: UILabel!
    
    @IBOutlet weak var driverCapacity: UILabel!
    
    @IBOutlet weak var driverFee: UILabel!
    
    @IBOutlet weak var driverSetdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var recordData: DriverSetRecord? {
        didSet {
            
            
            driverBoarding.text = recordData?.driverDeparture
            driverDestination.text = recordData?.driverDestination
            driverCapacity.text = String(describing: recordData?.driverSetPeople)
            driverFee.text = String(describing:recordData?.driverSetFee)
            driverSetdate.text = recordData?.driverSetDate
            
        }
    }
    
}
