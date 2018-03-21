//
//  Common.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/21.
//

import Foundation

class Common {
    
    static let shared = Common()
    private init(){
        
    }
    
    func getMyDriverTrips(diverTripsArray:[[String:Any]]) -> Array<DriverTrip> {
        var myDriverTripsArray: [DriverTrip] = []
        diverTripsArray.forEach { (trip) in
            let tripId = trip["trip_ip"] as! String
            //let memberNo = trip["member_no"] as! Int
            let departure = trip["boarding"] as! String
            let destination = trip["destination"] as! String
            let carNo = trip["car_no"] as! String
            let people = trip["people"] as! Int
            let fee = trip["fee"] as! Int
            //let status = trip["status"] as! Int
            let date = trip["date"] as! String
            //let departureLat = trip["member_no"] as! Int
            //let departureLon = trip["member_no"] as! Int
            //let destinationLat = trip["lat"] as! Double
            //let destinationLon = trip["lon"] as! Double
            
            let driverTrip = DriverTrip(tripId: tripId, memberNo: 0, departure: departure, destination: destination, carNo: carNo, people: people, fee: fee, status: "", date: date, departureLat: 0, departureLon: 0, destinationLat: 0, destinationLon: 0)
            myDriverTripsArray.append(driverTrip)
        }
        return myDriverTripsArray
    }
    
    func getMyPassengerTrips(passengerTripsArray:[[String:Any]]) -> Array<Trip> {
        var myPassengerTripsArray: [Trip] = []
        passengerTripsArray.forEach { (trip) in
            let tripId = trip["trip_ip"] as! String
            //let memberNo = trip["member_no"] as! Int
            let boarding = trip["boarding"] as! String
            let destination = trip["destination"] as! String
            //let people = trip["people"] as! Int
            //let status = trip["status"] as! Int
            let date = trip["date"] as! String
            //let departureLat = trip["member_no"] as! Int
            //let departureLon = trip["member_no"] as! Int
            //let destinationLat = trip["lat"] as! Double
            //let destinationLon = trip["lon"] as! Double
            
            let passengerTrip = Trip(tripId: tripId, memberNo: 0, destination: destination, boarding: boarding, people: 0, onMap: "", status: "", date: date, boardingLat: 0, boardingLon: 0, destinationLat: 0, destinationLon: 0)
            myPassengerTripsArray.append(passengerTrip)
        }
        return myPassengerTripsArray
    }
    
    func getFirstDriverTrip(diverTripsArray:[[String:Any]]) -> DriverTrip {
        var firstTrip:DriverTrip?
        let tripsArray = getMyDriverTrips(diverTripsArray: diverTripsArray)
        firstTrip = tripsArray.sorted { $0.date < $1.date }.first
        return firstTrip!
    }
    
    func getFirstPassengerTrip(passengerTripsArray:[[String:Any]]) -> Trip {
        var firstTrip:Trip?
        let tripsArray = getMyPassengerTrips(passengerTripsArray: passengerTripsArray)
        firstTrip = tripsArray.sorted { $0.date < $1.date }.first
        return firstTrip!
    }
    
}
