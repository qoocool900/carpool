//
//  Trip.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/8.
//

import Foundation

class Trip {
    var memberNo, people, onMap, status:Int
    var tripId, destination, boarding, date:String
    
    init(tripId:String, memberNo:Int, destination:String, boarding:String, people:Int, onMap:Int, status:Int, date:String) {
        self.tripId = tripId
        self.memberNo = memberNo
        self.destination = destination
        self.boarding = boarding
        self.people = people
        self.onMap = onMap
        self.status = status
        self.date = date
    }
}
