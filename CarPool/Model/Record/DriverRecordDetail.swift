//
//  DriverRecordDetail.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import Foundation

class DriverRecordDetail{
    var startLocation: String
    var endLocation: String
    var passengerName: String
    var passengerCount: Int
    var phoneNumber: String
    var onTime: String
    var offTime: String
    
    
    init(_ startLocation: String, _ endLocation: String,
         _ passengerName: String, _ phoneNumber: String,
         _ passengerCount: Int, _ onTime: String, _ offTime: String) {
        
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.passengerName = passengerName
        self.phoneNumber = phoneNumber
        self.passengerCount = passengerCount
        self.onTime = onTime
        self.offTime = offTime
    }
    
    static func allTripPassengerRecord() -> [DriverRecordDetail] {
        let record0 = DriverRecordDetail("台北車站","世貿中心","Penny Chen", "0911111111",1,"13:00","13:20")
        let record1 = DriverRecordDetail("台北101","木柵動物園","Ruby Cheng", "0922222222",2,"13:00","13:20")
        let record2 = DriverRecordDetail("新光三越南西店","忠孝東路ＳＯＧＯ","Winnie Hu", "0933333333",1,"13:00","13:20")
        return [record0, record1,record2]
    }

}
