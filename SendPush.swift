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
        
        //print("------from SendPush method + \(os)")
        
        let sendTokenURL = NSURL(string: "https://sheltered-wave-14675.herokuapp.com/sendPush")!
        let request = NSMutableURLRequest(URL: sendTokenURL)
        request.HTTPBody = "os=\(receiverOs)&to=\(messageReceiver)&title=\(title)&message=\(message)&type=\(type)=\(braceletSelected)&braceletId=\(braceletId)".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            print("AFTER POST")
            print("Data: ", data)
            print("Response: ", response)
            print("Error: ", error)
            }.resume()
        
    }

}
