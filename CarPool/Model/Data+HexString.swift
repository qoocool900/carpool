//
//  Data+HexString.swift
//  HelloMyPushMessage
//
//  Created by 林昱丞 on 2018/2/7.
//  Copyright © 2018年 林昱丞. All rights reserved.
//

import Foundation

extension Data {
    
    var hexString:String {
        // self 代表data本身
        return self.map { String(format: "%02X", $0) }.joined()
    }
}
