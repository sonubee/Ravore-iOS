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
        
        let config = UAConfig.defaultConfig()
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
        
        //postDeviceTokenToServer(channelID, deviceToken: deviceToken)
        
        UAirship.push().updateRegistration()
    }
}