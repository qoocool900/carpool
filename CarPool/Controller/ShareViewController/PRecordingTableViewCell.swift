//
//  PRecordingTableViewCell.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/16.
//

import UIKit

class PRecordingTableViewCell: UITableViewCell {

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

}
