//
//  CustomAnnotation.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/11.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    let destination: String?
    let people: String?
    let fee: String?
    let coordinate: CLLocationCoordinate2D
    init(destination: String, people: String, fee:String, coordinate: CLLocationCoordinate2D) {
        self.destination = destination
        self.people = people
        self.fee = fee
        self.coordinate = coordinate
        super.init()
    }
}
