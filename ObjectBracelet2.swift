//
//  ObjectBracelet2.swift
//  Ravore2
//
//  Created by Admin on 4/25/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ObjectBracelet2: NSObject {
    var receiverId: String
    var giverId: String
    var dateCreated: String
    var dateReceived: String
    var dateRegistered: String
    var braceletId: String
    var transferNumber: Int
    
    init(receiverId: String, giverId: String, dateCreated: String, dateReceived: String, dateRegistered: String, braceletId: String, transferNumber: Int){
        self.receiverId = receiverId
        self.giverId = giverId
        self.dateCreated = dateCreated
        self.dateReceived = dateReceived
        self.dateRegistered = dateRegistered
        self.braceletId = braceletId
        self.transferNumber = transferNumber
    }
    
    override init (){
        self.receiverId = ""
        self.giverId = ""
        self.dateCreated = ""
        self.dateReceived = ""
        self.dateRegistered = ""
        self.braceletId = ""
        self.transferNumber = 0
    }
    
    func getBraceletId() -> String {return braceletId}
}
