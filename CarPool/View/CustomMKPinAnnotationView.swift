//
//  CustomMKPinAnnotationView.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/11.
//

import UIKit
import MapKit

private let carPinImage = UIImage(named: "car-1")
class CustomMKPinAnnotationView: MKAnnotationView {

    weak var callOutView: CallOutView?
    
    override var annotation: MKAnnotation? {
        willSet {
            callOutView?.removeFromSuperview()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
        self.image = carPinImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
        self.image = carPinImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.callOutView?.removeFromSuperview()
            
            if let newCallOutView = loadCustomCallOutView() {
                newCallOutView.frame.origin.x -= newCallOutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCallOutView.frame.origin.y -= newCallOutView.frame.height
                
                self.addSubview(newCallOutView)
                self.callOutView = newCallOutView
                
                if animated {
                    self.callOutView!.alpha = 0.0
                    UIView.animate(withDuration: 0.3000, animations: {
                        self.callOutView!.alpha = 1.0
                    })
                }
            }
        } else {
            if callOutView != nil {
                if animated { // fade out animation, then remove it.
                    UIView.animate(withDuration: 0.3000, animations: {
                        self.callOutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.callOutView!.removeFromSuperview()
                    })
                } else { self.callOutView!.removeFromSuperview() } // just remove it.
            }
        }
    }
    
    func loadCustomCallOutView() -> CallOutView? {
        if let views = Bundle.main.loadNibNamed("CallOutView", owner: self, options: nil) as? [CallOutView], views.count > 0 {
            let callOutView = views.first!
            if let carAnnotation = annotation as? CustomAnnotation {
                callOutView.destinationLabel.text = carAnnotation.destination
                callOutView.peopleLabel.text = carAnnotation.people
                callOutView.feeLabel.text = carAnnotation.fee
            }
            return callOutView
        }
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.callOutView?.removeFromSuperview()
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let parentHitView = super.hitTest(point, with: event) { return parentHitView }
        else { // test in our custom callout.
            if callOutView != nil {
                return callOutView!.hitTest(convert(point, to: callOutView!), with: event)
            } else { return nil }
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
