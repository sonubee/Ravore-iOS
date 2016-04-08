//
//  ExtensionAppDelegate.swift
//  Ravore2
//
//  Created by Admin on 4/4/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Foundation
import AirshipKit

extension AppDelegate{
    func UASetup(){
        
        // Populate AirshipConfig.plist with your app's info from https://go.urbanairship.com
        // or set runtime properties here.
        let config = UAConfig.defaultConfig()
        
        // You can also programmatically override the plist values:
        // config.developmentAppKey = "YourKey"
        // etc.
        
        // Call takeOff (which creates the UAirship singleton)
        
        
        config.developmentAppKey = "toDJ-fwhRj211DjZUWL80w"
        config.developmentAppSecret = "3qkd2NWmS62HgNdpSlkMDw"
        config.productionAppKey = "eXJUniLXSk2Tm1RZq0qgMQ"
        config.productionAppSecret = "hE1GXlSYT8ihVpWujxC_6A"
        
        UAirship.takeOff(config)
        
        UAirship.push().userNotificationTypes = ([UIUserNotificationType.Alert,
            UIUserNotificationType.Badge,
            UIUserNotificationType.Sound])
        
        UAirship.push().userPushNotificationsEnabled = true
        
        UAirship.push().namedUser.identifier = UDID
        
        UAirship.push().resetBadge()
        
        PushToken.pushUAirship()
        
/*
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
*/
        postDeviceTokenToServer(channelID, deviceToken: deviceToken)
        
        UAirship.push().updateRegistration()
    }
}