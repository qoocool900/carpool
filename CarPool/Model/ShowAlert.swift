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
