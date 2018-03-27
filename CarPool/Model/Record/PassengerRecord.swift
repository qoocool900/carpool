//
//  RecordItem.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/7.
//

import Foundation

class PassengerRecord{
    var pStartLocation: String
    var pEndLocation: String
    var startLocation: String
    var endLocation: String
    var date: String
    var driverFirstName: String
    var driverLastName: String
    var carNumber: String
    var driverPhone:String
    var onTime: String
    var offTime: String
    var driverMemberNo: Int
    var driverTripId: String
    
    init(pStartLocation: String, pEndLocation: String, startLocation: String, endLocation: String, date: String, driverFirstName: String, driverLastName: String, carNumber: String, driverPhone: String, onTime: String, offTime: String, driverMemberNo: Int, driverTripId: String) {
        self.pStartLocation = pStartLocation
        self.pEndLocation = pEndLocation
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
        self.driverFirstName = driverFirstName
        self.driverLastName = driverLastName
        self.carNumber = carNumber
        self.driverPhone = driverPhone
        self.onTime = onTime
        self.offTime = offTime
        self.driverMemberNo = driverMemberNo
        self.driverTripId = driverTripId
    }
    
    //MARK: -Link to DataBase
    //getProcessingRecordings
    typealias Completion = (_ result: [PassengerRecord]) -> Void
    static func getPassengerProcessingInfo(loginMemberNo: Int, completion: @escaping Completion){
        var recordings = [PassengerRecord]()
        Communicator.shared.getMatchRecords(memberNo: loginMemberNo, status: 0, role: 0) { (error, result) in
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
                var recording: PassengerRecord
                for record in content{
                    let pStartLocation = record["p_boarding"] as! String
                    let pEndLocation = record["p_destination"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = (record["date"] as! NSString).substring(with: NSRange(location:0, length:10))
                    let driverFirstName = record["firstName"] as! String
                    let driverLastName = record["lastName"] as! String
                    let carNumber = record["carNo"] as! String
                    let driverPhone = record["phone"] as! String
                    
                    var onTime =  record["onTime"] as! String
                    var offTime =  record["offTime"] as! String
                    if  onTime != ""{
                        onTime = (onTime as NSString).substring(with: NSRange(location:11, length:5))
                    } else {
                        onTime = ""
                    }
                    if  offTime != ""{
                        offTime = (offTime as NSString).substring(with: NSRange(location:11, length:5))
                    } else {
                        offTime = ""
                    }
                    
                    let driverMemberNo = record["memberNo"] as! Int
                    let driverTripId = record["tripID"] as! String
                    recording = PassengerRecord(pStartLocation: pStartLocation, pEndLocation: pEndLocation, startLocation: startLocation,endLocation: endLocation, date: date,driverFirstName: driverFirstName,driverLastName: driverLastName,carNumber: carNumber,driverPhone: driverPhone,onTime: onTime,offTime: offTime, driverMemberNo: driverMemberNo,driverTripId: driverTripId)
                    recordings.append(recording)
                }
                completion(recordings)
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    //getProcessingRecordings
    static func getPassengerHistoryInfo(loginMemberNo: Int, completion: @escaping Completion){
        var recordings = [PassengerRecord]()
        Communicator.shared.getMatchRecords(memberNo: loginMemberNo, status: 1, role: 0) { (error, result) in
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
                var recording: PassengerRecord
                for record in content{
                    let pStartLocation = record["p_boarding"] as! String
                    let pEndLocation = record["p_destination"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = (record["date"] as! NSString).substring(with: NSRange(location:0, length:10))
                    let driverFirstName = record["firstName"] as! String
                    let driverLastName = record["lastName"] as! String
                    let carNumber = record["carNo"] as! String
                    let driverPhone = record["phone"] as! String
                    var onTime =  record["onTime"] as! String
                    var offTime =  record["offTime"] as! String
                    if  onTime != ""{
                        onTime = (onTime as NSString).substring(with: NSRange(location:11, length:5))
                    } else {
                        onTime = ""
                    }
                    if  offTime != ""{
                        offTime = (offTime as NSString).substring(with: NSRange(location:11, length:5))
                    } else {
                        offTime = ""
                    }
                    let driverMemberNo = record["memberNo"] as! Int
                    let driverTripId = record["tripID"] as! String
                    recording = PassengerRecord(pStartLocation: pStartLocation, pEndLocation: pEndLocation, startLocation: startLocation,endLocation: endLocation, date: date,driverFirstName: driverFirstName,driverLastName: driverLastName,carNumber: carNumber,driverPhone: driverPhone,onTime: onTime,offTime: offTime, driverMemberNo: driverMemberNo,driverTripId: driverTripId)
                    recordings.append(recording)
                }
                completion(recordings)
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    //    static func allProcessingRecord() -> [PassengerRecord] {
    //        let processingRecord = PassengerRecord(startLocation: "台北車站",endLocation: "世貿中心", date: "2018/01/11",driverFirstName: "Eric ",driverLastName: "Lin",carNumber: "ABC-1234", driverPhone: "0911111111",onTime: "13:00",offTime: "13:20", driverMemberNo: 3,driverTripId: "D180308004")
    //        return [processingRecord]
    //    }
    //    
    //    static func allHistoryRecord() -> [PassengerRecord] {
    //        let record1 = PassengerRecord(startLocation: "台北101",endLocation: "木柵動物園", date: "2018/01/03",driverFirstName: "Alan",driverLastName: "Lee",carNumber: "ABC-5678", driverPhone: "0922222222",onTime: "13:00",offTime: "13:20", driverMemberNo: 3,driverTripId: "D180308003")
    //        let record2 = PassengerRecord(startLocation: "新光三越南西店",endLocation: "忠孝東路ＳＯＧＯ", date: "2018/01/02",driverFirstName: "Patric",driverLastName: "Lo",carNumber: "DEF-1234",driverPhone: "0933333333",onTime: "13:00",offTime: "13:20", driverMemberNo: 3,driverTripId: "D180308002")
    //        let record3 = PassengerRecord(startLocation: "台北國稅局",endLocation: "宏泰世紀大樓", date: "2018/01/01",driverFirstName: "Grace",driverLastName: "Wang",carNumber: "DEF-5678",driverPhone: "0944444444",onTime: "13:00",offTime: "13:20", driverMemberNo: 3,driverTripId: "D180308001")
    //        return [record1,record2,record3]
    //    }
}
