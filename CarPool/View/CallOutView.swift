//
//  CallOutView.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/11.
//

import UIKit

protocol inviteRidingCallOutViewDelegate:class {
    func inviteRiding()
}

class CallOutView: UIView {

    weak var delegate: inviteRidingCallOutViewDelegate?
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func inviteButtonPressed(_ sender: Any) {
        delegate?.inviteRiding()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
