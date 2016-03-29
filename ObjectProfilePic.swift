//
//  ObjectProfilePic.swift
//  Ravore2
//
//  Created by Admin on 3/1/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit

class ObjectProfilePic: NSObject {
    var userId: String
    var url: String
    var urlVersion: String
    var fullPhotoUrl: String
    var fullPhotoVersion: String
    
    init(userId: String, url: String, urlVersion: String, fullPhotoUrl: String, fullPhotoVersion: String){
        self.userId = userId
        self.url = url
        self.urlVersion = urlVersion
        self.fullPhotoUrl = fullPhotoUrl
        self.fullPhotoVersion = fullPhotoVersion
    }
}
