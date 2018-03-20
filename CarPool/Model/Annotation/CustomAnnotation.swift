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
    let destination:String?
    let startPosition:String?
    let people:String?
    let fee:String?
    let phone:String?
    let score:Double?
    let coordinate:CLLocationCoordinate2D
    init(role:Int, destination:String, startPosition:String, people:String, fee:String, phone:String, score:Double, coordinate: CLLocationCoordinate2D) {
        self.role = role
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
