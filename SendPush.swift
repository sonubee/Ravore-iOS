//
//  SendPush.swift
//  Ravore2
//
//  Created by Admin on 3/27/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class SendPush: NSObject {
    

    
    class func methodToTest(message : String, messageReceiverId : String, title : String, type : String, braceletId : String){
        
        //var messageSender = ""
        var messageReceiver = ""
        var receiverOs = ""
        
        print("Receiver: \(messageReceiverId)")
        
        for token : ObjectToken in allTokens {
            if token.userId == messageReceiverId {
                messageReceiver = token.token
                receiverOs = token.os
            }
        }
        
        let sendBody = "os=\(receiverOs)&to=\(messageReceiver)&title=\(title)&message=\(message)&type=\(type)=\(braceletSelected)&braceletId=\(braceletId)"
        
        SendServerRequest.sendRequest("\(useHeroku)sendPush", body: sendBody)
    }

}
