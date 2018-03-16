//
//  Car.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/8.
//

import Foundation


class Car {
    var carNo, type, color, brand:String
    
    init(carNo:String, type:String, color:String, brand:String) {
        self.carNo = carNo
        self.type = type
        self.color = color
        self.brand = brand
    }
}
