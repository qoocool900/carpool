//
//  DriverTrip.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/8.
//

import Foundation

class DriverTrip {
    var tripId, memberNo, people, fee, status:Int
    var destination, carNo, date:String
    
    init(tripId:Int, memberNo:Int, destination:String, carNo:String, people:Int, fee:Int, status:Int, date:String) {
        self.tripId = tripId
        self.memberNo = memberNo
        self.destination = destination
        self.carNo = carNo
        self.people = people
        self.fee = fee
        self.status = status
        self.date = date
    }
}
