import GoogleMaps
import UIKit
import AirshipKit
//var tempChannel = ""
var channelID = ""
var deviceToken = ""


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Localytics.autoIntegrate("5e072565063e6b08733a5dd-6f2f74b8-f092-11e5-8154-0086bc74ca0f", launchOptions: launchOptions)
        
        initializeNotificationServices()
        
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDxUDQj8H6H7412z1AdKVnN00aYdqWqZbk")
        
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
        
        if UAirship.push().channelID == nil {
            channelID = "not set yet"
            print("Channel ID Not Set Yet")
        }
        
        else {
            channelID = UAirship.push().channelID!
            print("--Channel ID: \(channelID)")
        }
        
        if UAirship.push().deviceToken == nil {
            deviceToken = "not set yet"
            print("Device Token Not Set Yet")
        }
        
        else {
            deviceToken = UAirship.push().deviceToken!
            print("--Device Token: \(UAirship.push().deviceToken!)")
        }
        
        print("--After ID's--")
        
        postDeviceTokenToServer(channelID, deviceToken: deviceToken)

        
        UAirship.push().updateRegistration()
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let deviceTokenStr = convertDeviceTokenToString(deviceToken)
        // ...register device token with our Time Entry API server via REST
      
        print(deviceTokenStr)
      
        print("Before Tokens1111111111111111111111111")
        print("Notification Token: ", deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Device token for push notifications: FAIL -- ")
        print(error.description)
        
        Toast.makeToast("Failed Token Registration").show()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func convertDeviceTokenToString(deviceToken:NSData) -> String {
        //  Convert binary Device Token to a String (and remove the <,> and white space charaters).
        var deviceTokenStr = deviceToken.description.stringByReplacingOccurrencesOfString(">", withString: "", options: .CaseInsensitiveSearch, range: nil)
        deviceTokenStr = deviceTokenStr.stringByReplacingOccurrencesOfString("<", withString: "", options: .CaseInsensitiveSearch, range: nil)
        deviceTokenStr = deviceTokenStr.stringByReplacingOccurrencesOfString(" ", withString: "", options: .CaseInsensitiveSearch, range: nil)
        
        // Our API returns token in all uppercase, regardless how it was originally sent.
        // To make the two consistent, I am uppercasing the token string here.
        deviceTokenStr = deviceTokenStr.uppercaseString
        return deviceTokenStr
    }

    // Called when a notification is received and the app is in the
    // foreground (or if the app was in the background and the user clicks on the notification).
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        // display the userInfo
        if let notification = userInfo["aps"] as? NSDictionary,
            let alert = notification["alert"] as? String {
                var alertCtrl = UIAlertController(title: "Time Entry", message: alert as String, preferredStyle: UIAlertControllerStyle.Alert)
                alertCtrl.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                // Find the presented VC...
                var presentedVC = self.window?.rootViewController
                while (presentedVC!.presentedViewController != nil)  {
                    presentedVC = presentedVC!.presentedViewController
                }
                presentedVC!.presentViewController(alertCtrl, animated: true, completion: nil)
                
                // call the completion handler
                // -- pass in NoData, since no new data was fetched from the server.
                completionHandler(UIBackgroundFetchResult.NoData)
        }
    }
    
    func postDeviceTokenToServer(channelId : String, deviceToken: String) {
        print("******************************************************")
        let sendTokenURL = NSURL(string: "https://sheltered-wave-14675.herokuapp.com/postIOSToken")!
        let request = NSMutableURLRequest(URL: sendTokenURL)
        request.HTTPBody = "token=\(channelId)&UDID=\(UDID)&deviceToken=\(deviceToken)".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            print("AFTER POST")
            print("Data: ", data)
            print("Response: ", response)
            print("Error: ", error)
            }.resume()
    }
    
    func initializeNotificationServices() -> Void {
        let settings = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        // This is an asynchronous method to retrieve a Device Token
        // Callbacks are in AppDelegate.swift
        // Success = didRegisterForRemoteNotificationsWithDeviceToken
        // Fail = didFailToRegisterForRemoteNotificationsWithError
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func receivedForegroundNotification(notification: [NSObject : AnyObject], fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)) {
        // App received a foreground notification
        
        // Call the completion handler
        completionHandler(UIBackgroundFetchResult.NoData)
    }
    
    func launchedFromNotification(notification: [NSObject : AnyObject], fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)) {
        // App was launched from a notification
        
        // Call the completion handler
        completionHandler(UIBackgroundFetchResult.NoData)
    }
    
    func launchedFromNotification(notification: [NSObject : AnyObject], actionIdentifier identifier: String, completionHandler: () -> Void) {
        // App was launched from a notification action button
        
        // Call the completion handler
        completionHandler()
    }
    
    
    func receivedBackgroundNotification(notification: [NSObject : AnyObject], actionIdentifier identifier: String, completionHandler: () -> Void) {
        // App was launched in the background from a notificaiton action button
        
        // Call the completion handler
        completionHandler()
    }
    
    func receivedBackgroundNotification(notification: [NSObject : AnyObject], fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)) {
        // App received a background notification
        
        // Call the completion handler
        completionHandler(UIBackgroundFetchResult.NoData)
    }

}

