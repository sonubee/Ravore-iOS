//
//  BraceletInfo.swift
//  Ravore2
//
//  Created by Admin on 3/28/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import Foundation
import UIKit

class BraceletInfo {
    
    func braceletExistence(braceletId : String) -> Bool {
        
        var found = false
        
        for bracelet : ObjectBracelet in allBracelets {
            if bracelet.braceletId == braceletId {
                found = true
            }
            
        }
        return found
    }
    
    func getBracelet(braceletId : String) -> ObjectBracelet {
        //var found = false
        var tempBracelet = ObjectBracelet()
        
        for bracelet : ObjectBracelet in allBracelets {
            if bracelet.braceletId == braceletId {
                braceletChosen = bracelet
                tempBracelet = bracelet
            }
            
        }
        return tempBracelet
    }
    
    func amIGiver (braceletId : String) -> Bool {
        
        var found = false
        
        for (var i=0; i < allBracelets.count; i++){
            if (braceletId == allBracelets[i].braceletId){
                if (allBracelets[i].giverId == UDID){
                    found = true
                }
            }
        }
        
        return found
    }
}