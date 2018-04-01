//
//  CustomAnnotation.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/11.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let role:Int? //0:driver ; 1:passenger
    let tripId:String?
    let destination:String?
    let startPosition:String?
    let people:Int?
    let fee:Int?
    let phone:String?
    let score:Double?
    var coordinate:CLLocationCoordinate2D
    init(role:Int, tripId:String, destination:String, startPosition:String, people:Int, fee:Int, phone:String, score:Double, coordinate: CLLocationCoordinate2D) {
        self.role = role
        self.tripId = tripId
        self.destination = destination
        self.startPosition = startPosition
        self.people = people
        self.fee = fee
        self.phone = phone
        self.score = score
        self.coordinate = coordinate
        super.init()
    }
}
