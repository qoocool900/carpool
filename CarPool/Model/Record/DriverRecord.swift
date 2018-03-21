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
    
    
    init(driverTripId: String,seqNo: Int,startLocation: String,endLocation: String, date: String) {
        self.driverTripId = driverTripId
        self.seqNo = seqNo
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
    }
    
    static func allProcessingRecord() -> [DriverRecord] {
        let processingRecord = DriverRecord(driverTripId: "D20180101004",seqNo: 4,startLocation: "台北車站",endLocation: "世貿中心", date: "2018/01/11")
        return [processingRecord]
    }
    
    static func allHistoryRecord() -> [DriverRecord] {
        let record1 = DriverRecord(driverTripId: "D20180101003",seqNo: 3,startLocation: "台北101",endLocation: "木柵動物園", date: "2018/01/03")
        let record2 = DriverRecord(driverTripId: "D20180101002",seqNo: 2,startLocation: "新光三越南西店",endLocation: "忠孝東路ＳＯＧＯ", date: "2018/01/02")
        let record3 = DriverRecord(driverTripId: "D20180101001",seqNo: 1,startLocation: "台北國稅局",endLocation: "宏泰世紀大樓", date: "2018/01/01")
        return [record1,record2,record3]
    }
    
    //MARK: -Link to DataBase
    //getProcessingRecordings
    static func getDriverProcessingInfo(loginMemberNo: Int) -> [DriverRecord]{
        var recordings = [DriverRecord]()
        Communicator.shared.getMatchRecords(memberNo: loginMemberNo, status: 0, role: 1) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            guard (result?.isEmpty)! else{
                return
            }
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [[String:Any]]
            let code = response["code"] as! Int
            
            if code == 0 {
                var recording: DriverRecord
                for record in content{
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = record["date"] as! String
                    let seqNo = record["seqNo"] as! Int
                    let driverTripId = record["tripID"] as! String
                    recording = DriverRecord(driverTripId: driverTripId, seqNo: seqNo, startLocation: startLocation, endLocation: endLocation, date: date)
                    recordings.append(recording)
                }
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
        return recordings
    }
    
    //getProcessingRecordings
    static func getDriverHistoryInfo(loginMemberNo: Int) -> [DriverRecord]{
        var recordings = [DriverRecord]()
        Communicator.shared.getMatchRecords(memberNo: loginMemberNo, status: 1, role: 1) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [[String:Any]]
            let code = response["code"] as! Int
            
            if code == 0 {
                var recording: DriverRecord
                for record in content{
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = record["date"] as! String
                    let seqNo = record["seqNo"] as! Int
                    let driverTripId = record["tripID"] as! String
                    recording = DriverRecord(driverTripId: driverTripId, seqNo: seqNo, startLocation: startLocation, endLocation: endLocation, date: date)
                    recordings.append(recording)
                }
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
        return recordings
    }
}
