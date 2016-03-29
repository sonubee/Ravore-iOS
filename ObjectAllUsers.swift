//
//  ObjectAllUsers.swift
//  Ravore2
//
//  Created by Admin on 3/16/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ObjectAllUsers: NSObject {
    var userId : String
    var dateCreated : String
    
    init (userId :String, dateCreated : String){
        self.userId = userId
        self.dateCreated = dateCreated
    }
    

}
