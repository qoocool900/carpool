//
//  RecordItem.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/7.
//

import Foundation

class PassengerRecord{
    
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
    
    init(_ startLocation: String, _ endLocation: String, _ date: String, _ driverFirstName: String, _ driverLastName: String, _ carNumber: String,
         _ driverPhone: String,_ onTime: String, _ offTime: String,_ driverMemberNo: Int, _ driverTripId: String) {
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
    
    static func allProcessingRecord() -> [PassengerRecord] {
        let processingRecord = PassengerRecord("台北車站","世貿中心", "2018/01/11","Eric ","Lin","ABC-1234", "0911111111","13:00","13:20", 3,"D180308004")
        return [processingRecord]
    }
    
    static func allHistoryRecord() -> [PassengerRecord] {
        let record1 = PassengerRecord("台北101","木柵動物園", "2018/01/03","Alan","Lee","ABC-5678", "0922222222","13:00","13:20", 3,"D180308003")
        let record2 = PassengerRecord("新光三越南西店","忠孝東路ＳＯＧＯ", "2018/01/02","Patric","Lo","DEF-1234","0933333333","13:00","13:20", 3,"D180308002")
        let record3 = PassengerRecord("台北國稅局","宏泰世紀大樓", "2018/01/01","Grace","Wang","DEF-5678","0944444444","13:00","13:20", 3,"D180308001")
        return [record1,record2,record3]
    }
    
    //MARK: -Link to DataBase
    
    // Get myTrip - passenger from database
//    func getMyTrip(memberNo: Int){
//        Communicator.shared.getMyTrips(memberNo: memberNo, role: 0) { (error, result) in
//            if let error = error {
//                NSLog("get myTrip information fail: \(error)")
//                return
//            }
//            乘客：   {"response":{"code":0,"msg":"Success ”},"content":[{ “tripID”:””, ”memberNo”:””, “destination”:””, “people”:””, “date”:””, “onMap”:””, “boarding”:””, “lat”:””, “lon”:”” }]}
//            // success
//            print(result!)
//            guard let starLoation = result!["boarding"] as? String else {
//                return
//            }
//            guard let endLocation = result!["destination"] as? String else {
//                return
//            }
//            guard let date = result!["date"] as? String else {
//                return
//            }
//            
//            guard let sex = result!["sex"] as? String else {
//                return
//            }
//            
//            self.lastNameTextField.text = lastName
//            self.firstNameTextField.text = firstName
//            self.phoneTextField.text = phone
//            self.gander = sex
//            self.checkGander(gander: self.gander)
//        }
//    }
}
