//
//  CustomMKPinAnnotationView.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/11.
//

import UIKit
import MapKit

private let carPinImage = UIImage(named: "car")
private let peoplePinImage = UIImage(named: "boy")
class CustomMKPinAnnotationView: MKAnnotationView {

    weak var callOutView: CallOutView?
    weak var inviteRidingDelegate: inviteRidingCallOutViewDelegate?
    
    override var annotation: MKAnnotation? {
        willSet {
            callOutView?.removeFromSuperview()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
        if reuseIdentifier == "Car" {
            self.image = carPinImage?.resizeWith(percentage: 0.6)
        } else {
            self.image = peoplePinImage?.resizeWith(percentage: 0.6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
        if reuseIdentifier == "Car" {
            self.image = carPinImage?.resizeWith(percentage: 0.6)
        } else {
            self.image = peoplePinImage?.resizeWith(percentage: 0.6)
        }
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
            callOutView.delegate = self.inviteRidingDelegate
            if let carAnnotation = annotation as? CustomAnnotation {
                guard let role = carAnnotation.role else {
                    return nil
                }
                if role == 0 {
                    callOutView.destinationLabel.text = carAnnotation.destination!
                    callOutView.peopleLabel.text = "乘載人數：\(carAnnotation.people!)"
                    callOutView.feeLabel.text = "費用：" + carAnnotation.fee!
                    callOutView.scoreLabel.text = "總評分：\(carAnnotation.score!)"
                } else {
                    callOutView.destinationLabel.text = carAnnotation.destination!
                    callOutView.peopleLabel.text = "搭乘人數：\(carAnnotation.people!)"
                    callOutView.feeLabel.text = "上車地點：" + carAnnotation.startPosition!
                    callOutView.scoreLabel.text = ""
                }
                
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


import UIKit

extension UIImage {
    
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}

