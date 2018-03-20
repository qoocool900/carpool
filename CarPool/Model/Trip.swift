//
//  Trip.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/8.
//

import Foundation

class Trip {
    var memberNo, people:Int
    var tripId, destination, boarding, date, status, onMap:String
    var boardingLat, boardingLon, destinationLat, destinationLon:Double
    
    init(tripId:String, memberNo:Int, destination:String, boarding:String, people:Int, onMap:String, status:String, date:String, boardingLat:Double, boardingLon:Double, destinationLat:Double, destinationLon:Double) {
        self.tripId = tripId
        self.memberNo = memberNo
        self.destination = destination
        self.boarding = boarding
        self.people = people
        self.onMap = onMap
        self.status = status
        self.date = date
        self.boardingLat = boardingLat
        self.boardingLon = boardingLon
        self.destinationLat = destinationLat
        self.destinationLon = destinationLon
    }
}
