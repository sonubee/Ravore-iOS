
import UIKit

class ObjectBracelet: NSObject {
    
    var receiverId: String
    var giverId: String
    var dateCreated: String
    var dateReceived: String
    var dateRegistered: String
    var braceletId: String
    
    init(receiverId: String, giverId: String, dateCreated: String, dateReceived: String, dateRegistered: String, braceletId: String){
        self.receiverId = receiverId
        self.giverId = giverId
        self.dateCreated = dateCreated
        self.dateReceived = dateReceived
        self.dateRegistered = dateRegistered
        self.braceletId = braceletId
    }
    
    override init (){
        self.receiverId = ""
        self.giverId = ""
        self.dateCreated = ""
        self.dateReceived = ""
        self.dateRegistered = ""
        self.braceletId = ""
    }

    func getBraceletId() -> String {return braceletId}
  
}
