//
//  ObjectToken.swift
//  Ravore2
//
//  Created by Admin on 3/25/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ObjectToken: NSObject {
    var os : String
    var token : String
    var userId : String
    
    init (os :String, token : String, userId : String){
        self.os = os
        self.token = token
        self.userId = userId
    }
}
