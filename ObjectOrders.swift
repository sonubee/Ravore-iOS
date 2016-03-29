//
//  ObjectOrders.swift
//  Ravore2
//
//  Created by Admin on 3/16/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ObjectOrders: NSObject {
    
    
    var kandiCount : Int
    var beadCount : Int
    var subtotalPrice : Int
    var shippingPrice: Double
    var totalPrice : Double
    
    var orderNumber : String
    var os : String
    var address: String
    var date : String
    var email : String
    var fullName: String
    var suiteApt : String
    var status : String
    var deviceId : String
    
    init (kandiCount : Int, beadCount : Int, subtotalPrice : Int, shippingPrice: Double, totalPrice : Double, orderNumber : String, os : String, address: String, date : String, email : String, fullName: String, suiteApt : String, status : String, deviceId : String) {
        
        self.kandiCount = kandiCount
        self.beadCount = beadCount
        self.subtotalPrice = subtotalPrice
        self.shippingPrice = shippingPrice
        self.totalPrice = totalPrice
        self.orderNumber = orderNumber
        self.os = os
        self.address = address
        self.date = date
        self.email = email
        self.fullName = fullName
        self.suiteApt = suiteApt
        self.status = status
        self.deviceId = deviceId
    }
    

}
