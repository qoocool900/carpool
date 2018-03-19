//
//  PassengerNotice.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import Foundation

class DriverNotice{
    var tripId: String
    var startLocation: String
    var endLocation: String
    var date: String
    var driverFirstName: String
    var driverLastName: String
    var driverPhone:String
    var carNumber: String
    var requestStatus:Int
    var carCapacity: Int
    
    init(tripId: String, startLocation: String, endLocation: String, date: String, driverFirstName: String, driverLastName: String, driverPhone: String, carNumber: String, requestStatus:Int, carCapacity:Int) {
        self.tripId = tripId
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
        self.driverFirstName = driverFirstName
        self.driverLastName = driverLastName
        self.driverPhone = driverPhone
        self.carNumber = carNumber
        self.requestStatus = requestStatus
        self.carCapacity = carCapacity
    }
    
    static func driverShared() -> DriverNotice {
        let record1 = DriverNotice(tripId: "D1803001",startLocation: "板橋火車站",endLocation: "世貿三館", date: "2018/01/11 12:01",driverFirstName: "Patric", driverLastName: "Lo",driverPhone: "0911131111",carNumber: "ABC-5699",requestStatus: 0,carCapacity: 4)
        return record1
    }
    
    static func passengerReceivedNotice() -> [DriverNotice] {
        let record1 = DriverNotice(tripId: "D1803001",startLocation: "台北車站",endLocation: "木柵動物園", date: "2018/01/11 12:02",driverFirstName: "Alan", driverLastName: "Lee",driverPhone: "0911111111",carNumber: "ABC-5678",requestStatus: 0,carCapacity: 4)
        let record2 = DriverNotice(tripId: "D1803002",startLocation: "松山車站",endLocation: "青年公園", date: "2018/01/11 12:03",driverFirstName: "Eric", driverLastName: "Lee",driverPhone: "0911111121",carNumber: "ABC-5679",requestStatus: 0,carCapacity: 4)
        return [record1,record2]
    }
    
    static func passengerRequestNotice() -> [DriverNotice] {
        let record1 = DriverNotice(tripId: "D1803003",startLocation: "台北車站",endLocation: "歷史博物館", date: "2018/01/11 12:04",driverFirstName: "Brian", driverLastName: "Lin",driverPhone: "0911111131",carNumber: "ABC-5678",requestStatus: 0,carCapacity: 4)
        let record2 = DriverNotice(tripId: "D1803004",startLocation: "松山車站",endLocation: "美術館", date: "2018/01/11 12:05",driverFirstName: "Sunny", driverLastName: "Lee",driverPhone: "0911111221",carNumber: "ABC-5689",requestStatus: 0,carCapacity: 4)
        return [record1,record2]
    }
}
