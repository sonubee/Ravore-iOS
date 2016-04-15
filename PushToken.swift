//
//  PushToken.swift
//  Ravore2
//
//  Created by Admin on 4/4/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Foundation
import AirshipKit

class PushToken {
    
    class func pushUAirship () {
        
        print("^^^^^^^^^^^^^Came to PushToken")
        
        if UAirship.push().channelID == nil {
            channelID = "not set yet"
            print("Channel ID Not Set Yet")
        }
 
        else {
            channelID = UAirship.push().channelID!
            print("Channel ID: \(channelID)")
        }
        
        if UAirship.push().deviceToken == nil {
            deviceToken = "not set yet"
            print("Device Token Not Set Yet")
        }
            
        else {
            deviceToken = UAirship.push().deviceToken!
            print("Device Token: \(UAirship.push().deviceToken!)")
        }
        
        
        print("trying to post device token !!!!!!!!!!!!!!!!")
        print(channelID)
        print(deviceToken)
        
        let sendBody = "token=\(channelID)&UDID=\(UDID)&deviceToken=\(deviceToken)"
        
        SendServerRequest.sendRequest("https://sheltered-wave-14675.herokuapp.com/postIOSToken", body: sendBody)
    }

    
}