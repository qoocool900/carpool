////
////  DriverSetRecord.swift
////  CarPool
////
////  Created by 胡靜諭 on 2018/3/22.
////
//
//import Foundation
////
//class DriverSetRecord{
//    var driverMemberNo: Int
//    var driverDeparture: String
//    var driverDestination: String
//    var driverSetFee: Int
//    var driverSetPeople: Int
//    var driverSetDate:String
//    
//    
//    init(driverDeparture: String,driverDestination: String,driverSetFee: Int,driverSetPeople: Int,driverSetDate:String) {
////        self.driverMemberNo = driverMemberNo
//        self.driverDeparture = driverDeparture
//        self.driverDestination = driverDestination
//        self.driverSetFee = driverSetFee
//        self.driverSetPeople = driverSetPeople
//        self.driverSetDate = driverSetDate
//}
////    static func getDriverSetRecord(loginMemberNo: Int) -> [DriverSetRecord]{
////        var recordings = [DriverSetRecord]()
////        Communicator.shared.getMyTrips(memberNo: loginMemberNo, role: 1, doneHandler: { (error, result) in
////
////            if let error = error {
////                NSLog("伺服器連線錯誤: \(error)")
////                return
////            }
////            // success
////            guard result?.isEmpty == false else {
////                return
////            }
////            let response = result!["response"] as! [String:Any]
////            let content = result!["content"] as! [[String:Any]]
////            let code = response["code"] as! Int
////            if code == 0 {
////                var recording: DriverSetRecord
////                for record in content{
////                    let driverDeparture = record["boarding"] as! String
////                    let driverDestination = record["destination"] as! String
////                    let driverSetFee = record["fee"] as! Int
////                    let driverSetPeople = record["people"] as! Int
////                    let driverSetDate = record["date"] as! String
////                    recording = DriverSetRecord(driverDeparture: driverDeparture, driverDestination: driverDestination,driverSetFee: driverSetFee, driverSetPeople: driverSetPeople, driverSetDate: driverSetDate)
////                    recordings.append(recording)
////                }
////            }
////            let msg = response ["msg"] as! String
////            print(msg)
////        })
////        return recordings
////    }
////
//
//}
//
