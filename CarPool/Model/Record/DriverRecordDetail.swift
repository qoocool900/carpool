//
//  DriverRecordDetail.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import Foundation

class DriverRecordDetail{
    var passengerTripId: String
    var startLocation: String
    var endLocation: String
    var passengerFirstName: String
    var passengerLastName: String
    var passengerCount: Int
    var passengerPhone: String
    var onTime: String
    var offTime: String
    var seqNo: Int = 0
    
    init(_ passengerTripId: String, _ startLocation: String, _ endLocation: String,
         _ passengerFirstName: String,_ passengerLastName: String, _ passengerPhone: String,
         _ passengerCount: Int, _ onTime: String, _ offTime: String) {
        
        self.passengerTripId = passengerTripId
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.passengerLastName = passengerLastName
        self.passengerFirstName = passengerFirstName
        self.passengerPhone = passengerPhone
        self.passengerCount = passengerCount
        self.onTime = onTime
        self.offTime = offTime
    }
    
    static func allTripPassengerRecord() -> [DriverRecordDetail] {
        let record0 = DriverRecordDetail("P20180101003","台北車站","世貿中心","Penny", "Chen", "0911111111",1,"13:00","13:20")
        let record1 = DriverRecordDetail("P20180101002","台北101","木柵動物園","Ruby", "Cheng", "0922222222",2,"13:00","13:20")
        let record2 = DriverRecordDetail("P20180101001","新光三越南西店","忠孝東路ＳＯＧＯ","Winnie", "Hu", "0933333333",1,"13:00","13:20")
        return [record0, record1,record2]
    }
    

}
