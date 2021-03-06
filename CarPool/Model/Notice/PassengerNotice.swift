//
//  PassengerNotice.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/19.
//

import Foundation

class PassengerNotice{
    var seqNo: Int
    var tripId: String
    var startLocation: String
    var endLocation: String
    var date: String
    var passengerCount: Int
    var passengerFirstName: String
    var passengerLastName: String
    var passengerPhone: String
    var status: Int
    
    init(seqNo: Int, tripId: String, startLocation: String, endLocation: String, date: String, passengerCount: Int, passengerFirstName: String, passengerLastName: String,passengerPhone: String, status: Int) {
        self.seqNo = seqNo
        self.tripId = tripId
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.date = date
        self.passengerCount = passengerCount
        self.passengerFirstName = passengerFirstName
        self.passengerLastName = passengerLastName
        self.passengerPhone = passengerPhone
        self.status = status
    }
    
    //Get Passenger Shared From Database
    typealias Completion = (_ result:Trip) -> Void
    static func getPassengerSharedInfo(loginMemberNo: Int, completion: @escaping Completion) {
        var firstTrip: Trip!
        
        Communicator.shared.getMyTrips(memberNo: loginMemberNo, role: 0) { (error, result) in
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
                firstTrip = Common.shared.getFirstPassengerTrip(passengerTripsArray: content)
                print("Notice Passenger Trip: \(firstTrip)")
                completion(firstTrip)
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    //Get Driver Received Notice From Database
    typealias CompletionReceived = (_ result: [PassengerNotice]) -> Void
    static func getDriverReceivedNoticeInfo(driverTripId: String, completion: @escaping CompletionReceived){
        var recordings = [PassengerNotice]()
        Communicator.shared.getMyRequests(tripID: driverTripId , role: 1, request: 1, status: 0) { (error, result) in
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
                var recording: PassengerNotice
                for record in content{
                    let seqNo = record["reqNo"] as! Int
                    let passengerTripId = record["tripID"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = (record["date"] as! NSString).substring(with: NSRange(location:0, length:16))
                    let passengerFirstName = record["firstName"] as! String
                    let passengerLastName = record["lastName"] as! String
                    let passengerPhone = record["phone"] as! String
                    let passengerCount = record["people"] as! Int
                    
                    recording = PassengerNotice(seqNo: seqNo, tripId: passengerTripId, startLocation: startLocation, endLocation: endLocation, date: date, passengerCount: passengerCount, passengerFirstName: passengerFirstName, passengerLastName: passengerLastName,passengerPhone: passengerPhone, status: 0)
                    recordings.append(recording)
                }
            }
            completion(recordings)
            let msg = response ["msg"] as! String
            print("Status = 0 :\(msg)")
        }
    }
    
    //Get Driver Request Notice From Database
    typealias CompletionRequest = (_ result: [PassengerNotice]) -> Void
    static func getDriverRequestNoticeInfo(driverTripId: String, completion: @escaping CompletionRequest){
        var recordings = [PassengerNotice]()
        Communicator.shared.getMyRequests(tripID: driverTripId , role: 1, request: 0, status: 0) { (error, result) in
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
                var recording: PassengerNotice
                for record in content{
                    let seqNo = record["reqNo"] as! Int
                    let passengerTripId = record["tripID"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = (record["date"] as! NSString).substring(with: NSRange(location:0, length:16))
                    let passengerFirstName = record["firstName"] as! String
                    let passengerLastName = record["lastName"] as! String
                    let passengerPhone = record["phone"] as! String
                    let passengerCount = record["people"] as! Int
                    recording = PassengerNotice(seqNo: seqNo, tripId: passengerTripId, startLocation: startLocation, endLocation: endLocation, date: date, passengerCount: passengerCount, passengerFirstName: passengerFirstName, passengerLastName: passengerLastName,passengerPhone: passengerPhone,status: 0)
                    recordings.append(recording)
                }
            }
            completion(recordings)
            let msg = response ["msg"] as! String
            print("Status = 0 :\(msg)")
        }
        
        Communicator.shared.getMyRequests(tripID: driverTripId , role: 1, request: 0, status: 1) { (error, result) in
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
                var recording: PassengerNotice
                for record in content{
                    let seqNo = record["reqNo"] as! Int
                    let passengerTripId = record["tripID"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = (record["date"] as! NSString).substring(with: NSRange(location:0, length:16))
                    let passengerFirstName = record["firstName"] as! String
                    let passengerLastName = record["lastName"] as! String
                    let passengerPhone = record["phone"] as! String
                    let passengerCount = record["people"] as! Int
                    recording = PassengerNotice(seqNo: seqNo, tripId: passengerTripId, startLocation: startLocation, endLocation: endLocation, date: date, passengerCount: passengerCount, passengerFirstName: passengerFirstName, passengerLastName: passengerLastName,passengerPhone: passengerPhone,status: 1)
                    recordings.append(recording)
                }
            }
            completion(recordings)
            let msg = response ["msg"] as! String
            print("Status = 1 :\(msg)")
        }
        
        Communicator.shared.getMyRequests(tripID: driverTripId , role: 1, request: 0, status: 2) { (error, result) in
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
                var recording: PassengerNotice
                for record in content{
                    let seqNo = record["reqNo"] as! Int
                    let passengerTripId = record["tripID"] as! String
                    let startLocation = record["boarding"] as! String
                    let endLocation = record["destination"] as! String
                    let date = (record["date"] as! NSString).substring(with: NSRange(location:0, length:16))
                    let passengerFirstName = record["firstName"] as! String
                    let passengerLastName = record["lastName"] as! String
                    let passengerPhone = record["phone"] as! String
                    let passengerCount = record["people"] as! Int
                    recording = PassengerNotice(seqNo: seqNo, tripId: passengerTripId, startLocation: startLocation, endLocation: endLocation, date: date, passengerCount: passengerCount, passengerFirstName: passengerFirstName, passengerLastName: passengerLastName,passengerPhone: passengerPhone,status: 2)
                    recordings.append(recording)
                }
            }
            completion(recordings)
            let msg = response ["msg"] as! String
            print("Status = 2 :\(msg)")
        }
    }
    
    //    static func passengerShared() -> PassengerNotice {
    //        let record1 = PassengerNotice(seqNo: 1, tripId: "P180301001", startLocation: "國父紀念館", endLocation: "世貿二館", date: "2018/01/11 12:01", passengerCount: 2, passengerFirstName: "Helen", passengerLastName: "Lin",passengerPhone: "098888899",requestStatus:0)
    //        return record1
    //    }
    //
    //    static func driverReceivedNotice() -> [PassengerNotice] {
    //        let record1 = PassengerNotice(seqNo: 2, tripId: "P180301001", startLocation: "台北車站", endLocation: "捷運中山站", date: "2018/01/11 12:02", passengerCount: 2, passengerFirstName: "Ally", passengerLastName: "Lin",passengerPhone: "098888881",requestStatus:0)
    //        let record2 = PassengerNotice(seqNo: 3, tripId: "P180301002", startLocation: "台北捷運站", endLocation: "台北101", date: "2018/01/11 12:00", passengerCount: 1, passengerFirstName: "Sandy", passengerLastName: "Wang",passengerPhone: "0988888882")
    //        return [record1,record2]
    //    }
    //
    //    static func driverRequestNotice() -> [PassengerNotice] {
    //        let record1 = PassengerNotice(seqNo: 4, tripId: "P180301003", startLocation: "捷運中山站", endLocation: "世貿二館", date: "2018/01/11 12:03", passengerCount: 1, passengerFirstName: "Vicky", passengerLastName: "Wu",passengerPhone: "0988888883")
    //        let record2 = PassengerNotice(seqNo: 5, tripId: "P180301004", startLocation: "木柵動物園", endLocation: "台北101", date: "2018/01/11 12:07", passengerCount: 1, passengerFirstName: "Jacky", passengerLastName: "Lee",passengerPhone: "0988888884")
    //        return [record1,record2]
    //    }
}

