//
//  PassengerNotice.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/19.
//

import Foundation

class PassengerNotice{
    var tripId: String
    var startLocation: String
    var endLocation: String
    var date: String
    var passengerCount: Int
    var passengerFirstName: String
    var passengerLastName: String
    var passengerPhone: String
    var requestStatus: Int
    
    init(tripId: String, startLocation: String, endLocation: String, date: String, passengerCount: Int, passengerFirstName: String, passengerLastName: String,passengerPhone: String,requestStatus:Int) {
        self.tripId = tripId
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
        self.passengerCount = passengerCount
        self.passengerFirstName = passengerFirstName
        self.passengerLastName = passengerLastName
        self.passengerPhone = passengerPhone
        self.requestStatus = requestStatus
    }
    
    static func passengerShared() -> PassengerNotice {
        let record1 = PassengerNotice(tripId: "P180301001", startLocation: "國父紀念館", endLocation: "世貿二館", date: "2018/01/11 12:01", passengerCount: 2, passengerFirstName: "Helen", passengerLastName: "Lin",passengerPhone: "098888899",requestStatus:0)
        return record1
    }
    
    static func driverReceivedNotice() -> [PassengerNotice] {
        let record1 = PassengerNotice(tripId: "P180301001", startLocation: "台北車站", endLocation: "捷運中山站", date: "2018/01/11 12:02", passengerCount: 2, passengerFirstName: "Ally", passengerLastName: "Lin",passengerPhone: "098888881",requestStatus:0)
        let record2 = PassengerNotice(tripId: "P180301002", startLocation: "台北捷運站", endLocation: "台北101", date: "2018/01/11 12:00", passengerCount: 1, passengerFirstName: "Sandy", passengerLastName: "Wang",passengerPhone: "0988888882",requestStatus:0)
        return [record1,record2]
    }
    
    static func driverRequestNotice() -> [PassengerNotice] {
        let record1 = PassengerNotice(tripId: "P180301003", startLocation: "捷運中山站", endLocation: "世貿二館", date: "2018/01/11 12:03", passengerCount: 1, passengerFirstName: "Vicky", passengerLastName: "Wu",passengerPhone: "0988888883",requestStatus:0)
        let record2 = PassengerNotice(tripId: "P180301004", startLocation: "木柵動物園", endLocation: "台北101", date: "2018/01/11 12:07", passengerCount: 1, passengerFirstName: "Jacky", passengerLastName: "Lee",passengerPhone: "0988888884",requestStatus:0)
        return [record1,record2]
    }
}

