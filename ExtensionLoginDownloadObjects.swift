
import Foundation
import UIKit
import PKHUD
import Firebase

extension FirstViewController {
    func downloadObjects() {
        
        HUD.show(.Progress)
        
        var count=0
        
        let getBracelets = Firebase(url:useFirebase+"Bracelets")
        
        getBracelets.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let receiver = snapshot.value.objectForKey("receiverId") as! String
            let giver = snapshot.value.objectForKey("giverId") as! String
            let created = snapshot.value.objectForKey("dateCreated") as! String
            let registered = snapshot.value.objectForKey("dateRegistered") as! String
            let received = snapshot.value.objectForKey("dateReceived") as! String
            let id = snapshot.value.objectForKey("braceletId") as! String
            
            let newBracelet = ObjectBracelet(receiverId: receiver, giverId: giver, dateCreated: created, dateReceived: received, dateRegistered: registered, braceletId: id)
            
            allBracelets.append(newBracelet)
            allIDs.append(id)
            
            braceletKeys[id] = snapshot.key
            
            //if (newBracelet.giverId == UDID || newBracelet.receiverId == UDID){
            //    registeredBracelets.append(newBracelet)
            //    self.performSegueWithIdentifier("goToAllMessages", sender: self)
            //}
            
            
            
            HUD.hide(afterDelay: 1.0)
            count++
        })
        
        getBracelets.observeEventType(.ChildChanged, withBlock: { snapshot in
            let title = snapshot.value.objectForKey("braceletId") as! String
            
            
            let receiver = snapshot.value.objectForKey("receiverId") as! String
            let giver = snapshot.value.objectForKey("giverId") as! String
            let created = snapshot.value.objectForKey("dateCreated") as! String
            let registered = snapshot.value.objectForKey("dateRegistered") as! String
            let received = snapshot.value.objectForKey("dateReceived") as! String
            let id = snapshot.value.objectForKey("braceletId") as! String
            
            let modifyBracelet = ObjectBracelet(receiverId: receiver, giverId: giver, dateCreated: created, dateReceived: received, dateRegistered: registered, braceletId: id)
            
            for (var i = 0; i < allBracelets.count ; i++) {
                if (allBracelets[i].braceletId == modifyBracelet.braceletId){
                    allBracelets[i] = modifyBracelet
                }
            }
        })
        
        let getPics = Firebase(url:useFirebase+"Users/ProfilePics")
        
        getPics.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let fullPhotoUrl = snapshot.value.objectForKey("fullPhotoUrl") as! String
            let fullPhotoVersion = snapshot.value.objectForKey("fullPhotoVersion") as! String
            let url = snapshot.value.objectForKey("url") as! String
            let urlVersion = snapshot.value.objectForKey("urlVersion") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let addProfile = ObjectProfilePic(userId: "\(userId)", url: "\(url)", urlVersion: "\(urlVersion)", fullPhotoUrl: "\(fullPhotoUrl)", fullPhotoVersion: "\(fullPhotoVersion)")

            //let addProfile = ObjectProfilePic(userId: userId, url: url, urlVersion: urlVersion, fullPhotoUrl: fullPhotoUrl, fullPhotoVersion: fullPhotoVersion)
            
            allPics.append(addProfile)
        })
        
        getPics.observeEventType(.ChildChanged, withBlock: { snapshot in
            
            let fullPhotoUrl = snapshot.value.objectForKey("fullPhotoUrl") as! String
            let fullPhotoVersion = snapshot.value.objectForKey("fullPhotoVersion") as! String
            let url = snapshot.value.objectForKey("url") as! String
            let urlVersion = snapshot.value.objectForKey("urlVersion") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let modifyProfile = ObjectProfilePic(userId: userId, url: url, urlVersion: urlVersion, fullPhotoUrl: fullPhotoUrl, fullPhotoVersion: fullPhotoVersion)
            
            for (var i = 0; i < allPics.count ; i++) {
                if (allPics[i].userId == modifyProfile.userId){
                    allPics[i] = modifyProfile
                }
            }
        })
        
        let getAllUsers = Firebase(url:useFirebase+"Users/AllUsers")
        
        getAllUsers.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let dateCreated = snapshot.value.objectForKey("dateCreated") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let addUser = ObjectAllUsers(userId: userId, dateCreated: dateCreated)
            
            allUsers.append(addUser)
            
        })
        
        let getAllOrders = Firebase(url:useFirebase+"Orders1")
        
        getAllOrders.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let address = snapshot.value.objectForKey("address") as! String
            let beadCount = snapshot.value.objectForKey("beadCount") as! Int
            let date = snapshot.value.objectForKey("date") as! String
            let deviceId = snapshot.value.objectForKey("deviceId") as! String
            let email = snapshot.value.objectForKey("email") as! String
            let fullName = snapshot.value.objectForKey("fullName") as! String
            let kandiCount = snapshot.value.objectForKey("kandiCount") as! Int
            let orderNumber = snapshot.value.objectForKey("orderNumber") as! String
            let os = snapshot.value.objectForKey("os") as! String
            let shippingPrice = snapshot.value.objectForKey("shippingPrice") as! Double
            let status = snapshot.value.objectForKey("status") as! String
            let subtotalPrice = snapshot.value.objectForKey("subtotalPrice") as! Int
            let suiteApt = snapshot.value.objectForKey("suiteApt") as! String
            let totalPrice = snapshot.value.objectForKey("totalPrice") as! Double
            let cat = snapshot.value.objectForKey("cat") as! Int
            let dog = snapshot.value.objectForKey("dog") as! Int
            let teddyBear = snapshot.value.objectForKey("teddyBear") as! Int
            let walrus = snapshot.value.objectForKey("walrus") as! Int
            let octopus = snapshot.value.objectForKey("octopus") as! Int
            
            let downloadOrder = ObjectOrders(kandiCount: kandiCount, beadCount: beadCount, subtotalPrice: subtotalPrice, shippingPrice: shippingPrice, totalPrice: totalPrice, orderNumber: orderNumber, os: os, address: address, date: date, email: email, fullName: fullName, suiteApt: suiteApt, status: status, deviceId: deviceId, cat: cat, dog: dog, walrus: walrus, octopus: octopus, teddyBear: teddyBear)
            
            if downloadOrder.deviceId == UDID {
                allOrders.append(downloadOrder)
            }
        })
        
        let getGCMTokens = Firebase(url:useFirebase+"Users/PushToken")
        
        getGCMTokens.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            let os = snapshot.value.objectForKey("os") as! String
            let token = snapshot.value.objectForKey("token") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let downloadToken = ObjectToken(os: os, token: token, userId: userId)
            
            allTokens.append(downloadToken)
/*
            print("--Searching Tokens on Firebase--")
            print("UserId: ", userId)
            print("Token on Firebase: ", token)
            print("This device Token: ", deviceToken)
*/
            if (deviceToken != "not set yet") {
                if token == deviceToken {
                    foundToken = true
                    print("TOKEN FOUND ON SERVER")
                }
            }
        })
        
        getGCMTokens.observeEventType(.ChildChanged, withBlock: { snapshot in
            
            let os = snapshot.value.objectForKey("os") as! String
            let token = snapshot.value.objectForKey("token") as! String
            let userId = snapshot.value.objectForKey("userId") as! String
            
            let downloadToken = ObjectToken(os: os, token: token, userId: userId)
            
            for (var i = 0; i < allTokens.count ; i++) {
                if (allTokens[i].userId == downloadToken.userId){
                    allTokens[i] = downloadToken
                }
            }
        })
/*
        if (devStatus == "production") {
            Firebase(url:useFirebase+"Users/\(UDID)").childByAppendingPath("userId").setValue(UDID)
            Firebase(url:useFirebase+"Users/\(UDID)").childByAppendingPath("lastLogin").setValue(shortDate)
            Firebase(url:useFirebase+"Users/\(UDID)").childByAppendingPath("os").setValue("ios")
        }
*/
        
        let getAllevents = Firebase(url:useFirebase+"Events")
        
        getAllevents.observeEventType(.ChildAdded, withBlock: { snapshot in
            
        
            let address = snapshot.value.objectForKey("address") as! String
            let camping = snapshot.value.objectForKey("camping") as! String
            let date = snapshot.value.objectForKey("date") as! String
            let imageUrl = snapshot.value.objectForKey("imageUrl") as! String
            let lat = snapshot.value.objectForKey("lat") as! Double
            let location = snapshot.value.objectForKey("location") as! String
            let longi = snapshot.value.objectForKey("longi") as! Double
            let name = snapshot.value.objectForKey("name") as! String
            let price = snapshot.value.objectForKey("price") as! String
            let ticketsSite = snapshot.value.objectForKey("ticketsSite") as! String
            let website = snapshot.value.objectForKey("website") as! String
        
            let downloadEvents = ObjectEvents(address: address, camping: camping, date: date, imageUrl: imageUrl, lat: lat, location: location, longi: longi, name: name, price: price, ticketsSite: ticketsSite, website: website)
            
            allEvents.append(downloadEvents)
            
            self.performSegueWithIdentifier("displayEventeSegue", sender: self)
        
        })
        
        
    }
    
    
}