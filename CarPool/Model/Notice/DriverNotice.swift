//
//  PassengerNotice.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/8.
//

import UIKit
import Foundation

class DriverNotice{
    var seqNo: Int
    var tripId: String
    var startLocation: String
    var endLocation: String
    var date: String
    var driverFirstName: String
    var driverLastName: String
    var driverPhone:String
    var carNumber: String
    var carCapacity: Int
    
    init(seqNo: Int, tripId: String, startLocation: String, endLocation: String, date: String, driverFirstName: String, driverLastName: String, driverPhone: String, carNumber: String, carCapacity:Int) {
        self.seqNo = seqNo
        self.tripId = tripId
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
        self.driverFirstName = driverFirstName
        self.driverLastName = driverLastName
        self.driverPhone = driverPhone
        self.carNumber = carNumber
        self.carCapacity = carCapacity
    }
    
    //Get Driver Shared From Database
    typealias Completion = (_ result:DriverTrip) -> Void
    static func getDriverSharedInfo(loginMemberNo: Int, completion: @escaping Completion){
        var firstTrip: DriverTrip!
        Communicator.shared.getMyTrips(memberNo: loginMemberNo, role: 1) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            guard result == nil || result?.isEmpty == false else {
                return
            }
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [[String:Any]]
            let code = response["code"] as! Int
            if code == 0 {
                firstTrip = Common.shared.getFirstDriverTrip(diverTripsArray: content)
                print(firstTrip)
                completion(firstTrip)
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    typealias CompletionReceived = (_ result: [DriverNotice]) -> Void
    //Get Passenger Received Notice From Database
    static func getPassengerReceivedNoticeInfo(passengerTripId: String, completion: @escaping CompletionReceived) {
        Communicator.shared.getMyRequests(tripID: passengerTripId , role: 0, request: 1, status: 0) { (error, result) in
          var recordings = [DriverNotice]()
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
                var recording: DriverNotice
                for record in content{
                    let seqNo = record["reqNo"] as! Int
                    let driverTripId = record["tripID"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = record["date"] as! String
                    let driverFirstName = record["firstName"] as! String
                    let driverLastName = record["lastName"] as! String
                    let driverPhone = record["phone"] as! String
                    let carNumber = record["carNo"] as! String
                    let carCapacity = record["people"] as! Int
                    recording = DriverNotice(seqNo: seqNo,tripId: driverTripId, startLocation: startLocation, endLocation: endLocation, date: date,driverFirstName: driverFirstName, driverLastName: driverLastName,driverPhone: driverPhone,carNumber: carNumber,carCapacity: carCapacity)
                    recordings.append(recording)
                }
                completion(recordings)
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    typealias CompletionRequest = (_ result: [DriverNotice]) -> Void
    //Get Passenger Request Notice From Database
    static func getPassengerRequestNoticeInfo(passengerTripId: String, completion: @escaping CompletionRequest){
        var recordings = [DriverNotice]()
        Communicator.shared.getMyRequests(tripID: passengerTripId , role: 0, request: 0, status: 0) { (error, result) in
            
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
                var recording: DriverNotice
                for record in content{
                    let seqNo = record["reqNo"] as! Int
                    let driverTripId = record["tripID"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = record["date"] as! String
                    let driverFirstName = record["firstName"] as! String
                    let driverLastName = record["lastName"] as! String
                    let driverPhone = record["phone"] as! String
                    let carNumber = record["carNo"] as! String
                    let carCapacity = record["people"] as! Int
                    recording = DriverNotice(seqNo: seqNo,tripId: driverTripId, startLocation: startLocation, endLocation: endLocation, date: date,driverFirstName: driverFirstName, driverLastName: driverLastName,driverPhone: driverPhone,carNumber: carNumber,carCapacity: carCapacity)
                    recordings.append(recording)
                }
                completion(recordings)
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    //    Update Status to Database
    static func updateStatus(reqNo: Int, status: Int, tripId: String) {
        Communicator.shared.updateStatus(reqNo: reqNo, tripId: tripId, status: status) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            guard result?.isEmpty == false else {
                return
            }
            let response = result!["response"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
        
    }
    
    //    static func driverShared() -> DriverNotice {
    //        let record1 = DriverNotice(seqNo: 0, tripId: "D1803001",startLocation: "板橋火車站",endLocation: "世貿三館", date: "2018/01/11 12:01",driverFirstName: "Patric", driverLastName: "Lo",driverPhone: "0911131111",carNumber: "ABC-5699",carCapacity: 4)
    //        return record1
    //    }
    //
    //    static func passengerReceivedNotice() -> [DriverNotice] {
    //        let record1 = DriverNotice(seqNo: 0, tripId: "D1803001",startLocation: "台北車站",endLocation: "木柵動物園", date: "2018/01/11 12:02",driverFirstName: "Alan", driverLastName: "Lee",driverPhone: "0911111111",carNumber: "ABC-5678",carCapacity: 4)
    //        let record2 = DriverNotice(seqNo: 0,tripId: "D1803002",startLocation: "松山車站",endLocation: "青年公園", date: "2018/01/11 12:03",driverFirstName: "Eric", driverLastName: "Lee",driverPhone: "0911111121",carNumber: "ABC-5679",carCapacity: 4)
    //        return [record1,record2]
    //    }
    //
    //    static func passengerRequestNotice() -> [DriverNotice] {
    //        let record1 = DriverNotice(seqNo: 0,tripId: "D1803003",startLocation: "台北車站",endLocation: "歷史博物館", date: "2018/01/11 12:04",driverFirstName: "Brian", driverLastName: "Lin",driverPhone: "0911111131",carNumber: "ABC-5678",carCapacity: 4)
    //        let record2 = DriverNotice(seqNo: 0,tripId: "D1803004",startLocation: "松山車站",endLocation: "美術館", date: "2018/01/11 12:05",driverFirstName: "Sunny", driverLastName: "Lee",driverPhone: "0911111221",carNumber: "ABC-5689",carCapacity: 4)
    //        return [record1,record2]
    //    }
    
}
