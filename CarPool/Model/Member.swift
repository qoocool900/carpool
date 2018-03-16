//
//  Member.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/7.
//

import Foundation

class Member {
    var memberNo:Int
    var mail, password, lastName, firstName, phone, gender, token:String
    var scoreDriver, scoreSafe, scoreComfort:Float
    
    init() {
        memberNo = 0
        mail = ""
        password = ""
        lastName = ""
        firstName = ""
        phone = ""
        gender = "M"
        token = ""
        scoreDriver = 0
        scoreSafe = 0
        scoreComfort = 0
    }
}
