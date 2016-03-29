

import UIKit

class ObjectMessage: NSObject {
    var message : String
    var sender : String
    var date : String
    var braceletId : String
    var timestamp : String
    
    init(message: String, sender: String, date: String, braceletId: String, timestamp: String){
        self.message = message
        self.sender = sender
        self.date = date
        self.braceletId = braceletId
        self.timestamp = timestamp
    }
}
