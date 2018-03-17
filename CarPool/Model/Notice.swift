//
//  PassengerNotice.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import Foundation

class Notice{
    var startLocation: String
    var endLocation: String
    var date: String
    var passengerCount: String
    var driverName: String
    var driverPhone:String
    var passengerName: String
    var passengerPhone: String
    var carNumber: String
    var requestStatus:String
    var carCapacity: String
    var onTime: String
    var offTime: String
    
    init(_ startLocation: String, _ endLocation: String, _ date: String, _ passengerCount: String, _ driverName: String, _ driverPhone: String, _ passengerName: String, _ passengerPhone: String, _ carNumber: String, _ requestStatus:String, _ carCapacity:String, _ onTime: String, _ offTime: String) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
        self.passengerCount = passengerCount
        self.driverName = driverName
        self.driverPhone = driverPhone
        self.passengerName = passengerName
        self.passengerPhone = passengerPhone
        self.carNumber = carNumber
        self.requestStatus = requestStatus
        self.carCapacity = carCapacity
        self.onTime = onTime
        self.offTime = offTime
    }
    
    static func allReceivedNotice() -> [Notice] {
        let record1 = Notice("台北車站","木柵動物園", "2018/01/11 12:02","0","Alan Lee","0911111111","","","ABC-5678","0","4","13:00", "13:20")
        let record2 = Notice("台北車站","宏泰世紀大樓", "2018/01/11 12:03","0","Albert Wang","0922222222","","","ABC-1200","0","3","13:00", "13:20")
        return [record1,record2]
    }
    
    
    static func allDriverReceivedNotice() -> [Notice] {
        let record1 = Notice("台北車站","捷運中山站", "2018/01/11 12:02","2","","","Ally Lin","0988888888","","1","","13:00", "13:20")
        let record2 = Notice("捷運中山站","宏泰世紀大樓", "2018/01/11 12:03","2","","","Tonny Chen","0933333333","","0","","13:00", "13:20")
        return [record1,record2]
    }
    
    static func allRequestNotice() -> [Notice] {
        let record1 = Notice("台北車站","木柵動物園", "2018/01/11 12:02","0","Alan Lee","0911111111","","","ABC-5678","0","4","13:00", "13:20")
        let record2 = Notice("台北車站","宏泰世紀大樓", "2018/01/11 12:03","0","Albert Wang","0922222222","","","ABC-1200","0","3","13:00", "13:20")
        return [record1,record2]
    }
    
    static func allDriverRequestNotice() -> [Notice] {
        let record1 = Notice("台北車站","木柵動物園", "2018/01/11 12:02","0","","","Alan Lee","0911111111","ABC-5678","0","4","13:00", "13:20")
        let record2 = Notice("台北車站","宏泰世紀大樓", "2018/01/11 12:03","0","","","Albert Wang","0922222222","ABC-1200","0","3","13:00", "13:20")
        return [record1,record2]
    }
}
