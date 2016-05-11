//
//  ObjectEvents.swift
//  Ravore2
//
//  Created by Admin on 5/10/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ObjectEvents: NSObject {
    
    var address : String
    var camping : String
    var date : String
    var imageUrl : String
    var lat : Double
    var location : String
    var longi : Double
    var name : String
    var price : String
    var ticketsSite : String
    var website : String
    
    init (address : String, camping : String, date : String, imageUrl : String, lat : Double, location : String, longi : Double, name : String, price : String, ticketsSite : String, website : String){
        self.address = address
        self.camping = camping
        self.date = date
        self.imageUrl = imageUrl
        self.lat = lat
        self.location = location
        self.longi = longi
        self.name = name
        self.price = price
        self.ticketsSite = ticketsSite
        self.website = website
    }

}
