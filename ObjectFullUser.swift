//
//  ObjectFullUser.swift
//  Ravore2
//
//  Created by Admin on 4/12/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Foundation

class ObjectFullUser : NSObject {
    var deviceId : String
    var lastLogin : String
    var os : String
    var token : String
    
    init (deviceId : String, lastLogin : String, os : String, token : String){
        self.deviceId = deviceId
        self.lastLogin = lastLogin
        self.os = os
        self.token = token
    }
    
}