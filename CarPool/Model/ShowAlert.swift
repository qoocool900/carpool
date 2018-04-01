//
//  ShowAlert.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/13.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message:String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    // 尚未完成
    func showComfirmAlert(message:String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(ok)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addRedDotAtTabBarItemIndex(index: Int) {
        for subview in tabBarController!.tabBar.subviews {
            
            if let subview = subview as? UIView {
                
                if subview.tag == 1234 {
                    subview.removeFromSuperview()
                    break
                }
            }
        }
        guard index != 1234 else {
            return
        }

        let RedDotRadius: CGFloat = 5
        let RedDotDiameter = RedDotRadius * 2
        
        let TopMargin:CGFloat = 5
        
        let TabBarItemCount = CGFloat(self.tabBarController!.tabBar.items!.count)
        
        let screenSize = UIScreen.main.bounds
        let HalfItemWidth = (screenSize.width) / (TabBarItemCount * 2)
        
        let  xOffset = HalfItemWidth * CGFloat(index * 2 + 1)
        
        let imageHalfWidth: CGFloat = (self.tabBarController!.tabBar.items![index] as! UITabBarItem).selectedImage!.size.width / 2
        
        let redDot = UIView(frame: CGRect(x: xOffset + imageHalfWidth - 7, y: TopMargin, width: RedDotDiameter, height: RedDotDiameter))
        
        redDot.tag = 1234
        redDot.backgroundColor = UIColor.red
        redDot.layer.cornerRadius = RedDotRadius
        
        self.tabBarController?.tabBar.addSubview(redDot)
        
    }
}

extension UIViewController {
    func callPhone(phoneNo:String) {
        if let url = URL(string: "tel:\(phoneNo)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

extension UITableView {
    func callPhone(phoneNo:String) {
        if let url = URL(string: "tel:\(phoneNo)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

extension UITableViewCell {
    func callPhone(phoneNo:String) {
        if let url = URL(string: "tel:\(phoneNo)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
