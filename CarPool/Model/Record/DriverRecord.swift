//
//  DriverRecord.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import Foundation

class DriverRecord{
    var driverTripId: String
    var seqNo: Int
    var startLocation: String
    var endLocation: String
    var date: String
    
    
    init(_ driverTripId: String, _ seqNo: Int,_ startLocation: String, _ endLocation: String, _ date: String) {
        self.driverTripId = driverTripId
        self.seqNo = seqNo
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
    }
    
    static func allProcessingRecord() -> [DriverRecord] {
        let processingRecord = DriverRecord("D20180101004",4,"台北車站","世貿中心", "2018/01/11")
        return [processingRecord]
    }
    
    static func allHistoryRecord() -> [DriverRecord] {
        let record1 = DriverRecord("D20180101003",3,"台北101","木柵動物園", "2018/01/03")
        let record2 = DriverRecord("D20180101002",2,"新光三越南西店","忠孝東路ＳＯＧＯ", "2018/01/02")
        let record3 = DriverRecord("D20180101001",1,"台北國稅局","宏泰世紀大樓", "2018/01/01")
        return [record1,record2,record3]
    }
}
