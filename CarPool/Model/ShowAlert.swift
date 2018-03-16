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
