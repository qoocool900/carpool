//
//  PRecordingTableViewCell.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/16.
//

import UIKit

class PRecordingTableViewCell: UITableViewCell {

    @IBOutlet weak var passengerSetDate: UILabel!
    @IBOutlet weak var passengerPeople: UILabel!
    @IBOutlet weak var passengerFee: UILabel!
    @IBOutlet weak var passengerBoarding: UILabel!
    @IBOutlet weak var passengerDestination: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var setData: DriverTrip? {
        didSet {
            passengerBoarding.text = setData?.departure
            passengerDestination.text = setData?.destination
            passengerSetDate.text = setData?.date
            passengerPeople.text = String(describing: setData?.people)
            passengerFee.text = String(describing: setData?.fee)
        }
    }

}
