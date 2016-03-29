//
//  SendServerRequest.swift
//  Ravore2
//
//  Created by Admin on 3/28/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class SendServerRequest: NSObject {
    
    class func sendRequest(url : String, body : String){
        
        let sendTokenURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: sendTokenURL)
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
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
