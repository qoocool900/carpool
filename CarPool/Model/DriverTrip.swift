//
//  DriverTrip.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/8.
//

import Foundation

class DriverTrip {
    var memberNo, people, fee:Int
    var tripId, destination, departure, carNo, date, status:String
    var departureLat, departureLon, destinationLat, destinationLon:Double
    
    init(tripId:String, memberNo:Int, departure:String, destination:String, carNo:String, people:Int, fee:Int, status:String, date:String, departureLat:Double, departureLon:Double, destinationLat:Double, destinationLon:Double) {
        self.tripId = tripId
        self.memberNo = memberNo
        self.departure = departure
        self.destination = destination
        self.carNo = carNo
        self.people = people
        self.fee = fee
        self.status = status
        self.date = date
        self.departureLat = departureLat
        self.departureLon = departureLon
        self.destinationLat = destinationLat
        self.destinationLon = destinationLon
    }
}

