//
//  Communicator.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/7.
//

import Foundation
import Alamofire
//import SwiftyJSON

let ACTION = "action"
let DATA_KEY = "data"
let RESULT_KEY = "result"

typealias DoneHandler = (_ error:Error?, _ result:[String:Any]?) -> Void
typealias DownloadDoneHandler = (_ error:Error?, _ result:Data?) -> Void

class Communicator {
    static let BASEURL = "http://114.34.110.248:7070/carpool/"
    let REGISTER_URL = BASEURL + "RegisterServlet"
    let LOGIN_URL = BASEURL + "LoginServlet"
    let MEMBER_URL = BASEURL + "MemberServlet"
    let TRIP_URL = BASEURL + "TripServlet"
    let LOCATION_URL = BASEURL + "TripLocationServlet"
    let RECORD_URL = BASEURL + "TripRecordServlet"
    let CAR_POOL_URL = BASEURL + "CarPoolServlet"
    let PUSH_URL = BASEURL + "PushNotificationServlet"
    static var token:String = ""
    
    // Singleton Support
    // 不同view controller 可以共用shared 任何一個vc 也可以改資料
    
    // static 靜態不會消失
    static let shared = Communicator()
    // init() 限制使用者只能建立一個 因為private 只有這裡可以init生出
    private init(){
        
    }
    
    // MARK: - RegisterServlet
    // 註冊，成功回傳 memberNo
    func doRegister(_ member:Member, doneHandler:@escaping DoneHandler) {
        print("UDID在這裡\(Communicator.token)")
        let parameters: [String : Any] = [ACTION:"doRegister", "mail":member.mail, "password":member.password, "lastName":member.lastName, "firstName":member.firstName, "phone":member.phone, "sex":member.gender, "udid":Communicator.token]
        
        
        doPost(urlString: REGISTER_URL, parameters: parameters, doneHandler: doneHandler)
        
    }
    
    // MARK: - LoginServlet
    // 登入檢查，成功回傳 memberNo
    func checkUser(mail:String, password:String, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"checkUser", "mail":mail, "password":password]

        doPost(urlString: LOGIN_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // MARK: - MemberServlet
    // 取得會員資料
    func getMemberInfo(memberNo:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getMemberInfo", "memberNo":memberNo]
        
        doPost(urlString: MEMBER_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 修改會員資料
    func modifyMemberInfo(_ member:Member, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"modifyMemberInfo", "memberNo":member.memberNo ,"lastName":member.lastName, "firstName":member.firstName, "phone":member.phone, "sex":member.gender]
        
        doPost(urlString: MEMBER_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 取得汽車資料
    func getCarInfo(memberNo:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getCarInfo", "memberNo":memberNo]
        
        doPost(urlString: MEMBER_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 修改汽車資料
    func modifyCarInfo(_ car:Car, memberNo:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"modifyCarInfo", "carNo":car.carNo, "memberNo":memberNo, "color":car.color, "type":car.type, "brand":car.brand]
        doPost(urlString: MEMBER_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 取得守衛資料
    func getGuardInfo(memberNo:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getGuardInfo", "memberNo":memberNo]
        
        doPost(urlString: MEMBER_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 修改守衛資料
    func modifyGuardInfo(memberNo:Int, guardMemberNo:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"modifyGuardInfo", "memberNo":memberNo, "guardNo":guardMemberNo]
        doPost(urlString: MEMBER_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // MARK: - TripLocationServlet
    // 下載路線
    func getRoutes(tripId:String, memberNo:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getRoutes", "tripID":tripId, "memberNo":memberNo]
        doPost(urlString: LOCATION_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // 上傳上車後路線
    func addRoutes(tripId:String, memberNo:Int, geoPosition:[[Double]], doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"addRoutes", "tripID":tripId, "memberNo":memberNo, "geoPosition":geoPosition]
        doPost(urlString: LOCATION_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 上傳user位置
    func addLocation(memberNo:Int, guardMemberNo:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"addLocation", "memberNo":memberNo, "lan":guardMemberNo, "lon":guardMemberNo]
        doPost(urlString: LOCATION_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // MARK: - TripServlet
    // 取得所有人發起的
    func getTrips(status:Int, onMap:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getTrips", "status":status, "onMap":onMap]
        doPost(urlString: TRIP_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 取得所有車發起的
    func getDriverTrips(status:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getDriverTrips", "status":status]
        doPost(urlString: TRIP_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 取得所有自己發起
    func getMyTrips(memberNo:Int, role:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getMyTrips", "memberNo":memberNo, "role":role]
        doPost(urlString: TRIP_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 乘客發起 增刪改
    func modifyTrip(_ trip:Trip, mode:String, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"modifyTrip", "mode":mode, "memberNo":trip.memberNo, "tripID":trip.tripId, "destination":trip.destination, "people":trip.people, "onMap":trip.onMap, "boarding":trip.boarding, "status":trip.status, "boardingLat":trip.boardingLat, "boardingLon":trip.boardingLon, "destinationLat":trip.destinationLat, "destinationLon":trip.destinationLon]
        doPost(urlString: TRIP_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 司機發起 增刪改
    func modifyDriverTrip(_ driverTrip:DriverTrip, mode:String, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"modifyDriverTrip", "mode":mode, "memberNo":driverTrip.memberNo, "tripID":driverTrip.tripId, "carNo":driverTrip.carNo, "people":driverTrip.people, "destination":driverTrip.destination, "departure":driverTrip.departure, "fee":driverTrip.fee, "status":driverTrip.status, "departureLat":driverTrip.departureLat, "departureLon":driverTrip.departureLon, "destinationLat":driverTrip.destinationLat, "destinationLon":driverTrip.destinationLon]
        doPost(urlString: TRIP_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // MARK: - TripRecordServlet
    // 取得所有記錄
    func getMatchRecords(memberNo:Int, status:Int, role:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getMatchRecords", "memberNo":memberNo, "status":status, "role":role]
        doPost(urlString: RECORD_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // 取得我自己載過的乘客
    func getPassengerRecords(driverTripID:String, doneHandler:@escaping DoneHandler) {
        let parameters:[String:Any] = [ACTION:"getPassengerRecords", "tripID":driverTripID]
        doPost(urlString: RECORD_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // 新增配對成功記錄 (暫無使用)
    func addRecord(driverTripID:String, passengerTripID:String, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"addRecord", "driverTripID":driverTripID, "passengerTripID":passengerTripID]
        doPost(urlString: RECORD_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 更新記錄 上下車
    func updateRecord(driverTripId:String, passengerTripId:String, status:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"updateRecord", "driverTripID":driverTripId, "passengerTripID":passengerTripId, "status":status]
        doPost(urlString: RECORD_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 評價記錄
    func addEvaluation(tripId:String, memberNo:Int, driverMemberNo:Int, scoreDriver:Float, scoreSafe:Float, scoreComfort:Float, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"addEvaluation", "tripID":tripId, "memberNo":memberNo, "driverMemberNo":driverMemberNo, "scoreDriver":scoreDriver, "scoreSafe":scoreSafe, "scoreComfort":scoreComfort]
        doPost(urlString: RECORD_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    // MARK: - CarPoolServlet
    // 取得目前自己有發過或受邀請的請求
    func getMyRequests(tripID:String, role:Int, request:Int, status:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"getMyRequests", "tripID":tripID, "role":role, "request":request, "status":status]
        print("tripID:\(tripID), role:\(role), request:\(request), status:\(status)")
        doPost(urlString: CAR_POOL_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 新增請求
    func addRequest(driverTripID:String, passengerTripID:String, reqType:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"addRequest", "driverTripID":driverTripID, "passengerTripID":passengerTripID, "reqType":reqType, "status":0]
        doPost(urlString: CAR_POOL_URL, parameters: parameters, doneHandler: doneHandler)
    }
    // 更新狀態
    func updateStatus(reqNo:Int, tripId:String, status:Int, doneHandler:@escaping DoneHandler) {
        let parameters: [String : Any] = [ACTION:"updateStatus", "reqNo":reqNo, "tripID":tripId, "status":status]
        print("updateStatus: reqNo\(reqNo), tripID:\(tripId), status:\(status)")
        doPost(urlString: CAR_POOL_URL, parameters: parameters, doneHandler: doneHandler)
    }
    
    
    private func doPost(urlString:String, parameters:[String:Any], doneHandler:@escaping DoneHandler) {
        
        // Perform Post!
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
//            print(response)
            self.handleResponse(response, doneHandler: doneHandler)
            
        }
        
        
    }
    
    private func handleResponse(_ response:DataResponse<Any>, doneHandler:DoneHandler) {
        switch response.result {
        case.success(let json):
            NSLog("doPost success with result: \(json)")
            // 因為這邊 Alamofire 都處理過 不太可能為 nil 所以幾乎用!
            let resultJSON = json as! [String:Any]
//            print(resultJSON)
            doneHandler(nil, resultJSON)
//            let response = resultJSON["response"] as! [String:Any]
//            let code = response["code"] as! Int
//            let msg = response["msg"] as! String
//
//
//            //print(contentArray)
//            if code >= 0 {
//                var content:[String:Any] = ["init":"init"]
//                //var contentArray:[[String:Any]] = []
//                if resultJSON["content"] == nil {
//                    content = response
//                    doneHandler(nil, resultJSON)
//                } else {
//                    //content = resultJSON["content"] as! [[String:Any]]
//                    if resultJSON["content"] is [[String:Any]] {
//                        //contentArray = resultJSON["content"] as! [[String:Any]]
//                        doneHandler(nil, resultJSON)
//                    } else {
//                        content = resultJSON["content"] as! [String:Any]
//                        doneHandler(nil, content)
//                    }
//                }
//                // 成功
//
//            } else {
//                // 失敗
//                print(code)
//                let error = NSError(domain: msg, code: -1, userInfo: nil)
//                doneHandler(error, response)
//            }
            
        case.failure(let error):
            NSLog("doPost fail with error: \(error)")
            doneHandler(error, nil)
        }
    }
}
