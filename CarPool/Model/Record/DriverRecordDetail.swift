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
    
    init(passengerTripId: String, startLocation: String, endLocation: String,
         passengerFirstName: String,passengerLastName: String,passengerPhone: String,passengerCount: Int,onTime: String, offTime: String) {
        
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
    
    //getProcessingRecordings
     typealias Completion = (_ result: [DriverRecordDetail]) -> Void
    static func getAllTripPassengerInfo(seqNo: Int, completion: @escaping Completion){
        var recordings = [DriverRecordDetail]()
        Communicator.shared.getPassengerRecords(seqNo: seqNo) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            guard result?.isEmpty == false else {
                return
            }
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [[String:Any]]
            let code = response["code"] as! Int
            
            if code == 0 {
                var recording: DriverRecordDetail
                for record in content{
                    let passengerTripId = record["tripID"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let passengerFirstName = record["firstName"] as! String
                    let passengerLastName = record["lastName"] as! String
                    let passengerPhone = record["phone"] as! String
                    let passengerCount = record["people"] as! Int
                    let onTime = record["onTime"] as! String
                    let offTime = record["offTime"] as! String
                    
                    recording = DriverRecordDetail(passengerTripId: passengerTripId, startLocation: startLocation, endLocation: endLocation,passengerFirstName: passengerFirstName,passengerLastName: passengerLastName,passengerPhone: passengerPhone,passengerCount: passengerCount,onTime: onTime, offTime: offTime)
                    
                    recordings.append(recording)
                }
            }
            let msg = response ["msg"] as! String
            print(msg)
            completion(recordings)
        }
    }
    
    //    static func allTripPassengerRecord() -> [DriverRecordDetail] {
    //        let record0 = DriverRecordDetail(passengerTripId: "P20180101003",startLocation: "台北車站",endLocation: "世貿中心",passengerFirstName: "Penny", passengerLastName: "Chen", passengerPhone: "0911111111",passengerCount: 1,onTime: "13:00",offTime: "13:20")
    //        let record1 = DriverRecordDetail(passengerTripId: "P20180101002",startLocation: "台北101",endLocation: "木柵動物園",passengerFirstName: "Ruby", passengerLastName: "Cheng", passengerPhone: "0922222222",passengerCount: 2,onTime: "13:00",offTime: "13:20")
    //        let record2 = DriverRecordDetail(passengerTripId: "P20180101001",startLocation: "新光三越南西店",endLocation: "忠孝東路ＳＯＧＯ",passengerFirstName: "Winnie", passengerLastName: "Hu", passengerPhone: "0933333333",passengerCount: 1,onTime: "13:00",offTime: "13:20")
    //        return [record0, record1,record2]
    //    }

}
