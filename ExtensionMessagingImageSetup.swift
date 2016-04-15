
import Foundation
import UIKit
import Toucan

extension ViewControllerMessaging {
    func setup(){
        
        
        self.tableView.rowHeight = 25
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        // Do any additional setup after loading the view.
        
        let tapGiverGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("giverImageTapped:"))
        giverImage.userInteractionEnabled = true
        giverImage.addGestureRecognizer(tapGiverGestureRecognizer)
        
        let tapReceiverGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("receiverImageTapped:"))
        receiverImage.userInteractionEnabled = true
        receiverImage.addGestureRecognizer(tapReceiverGestureRecognizer)
        
        giverImage.image = UIImage(named: "anon")
        receiverImage.image = UIImage(named: "anon")
        
        var tempImage : UIImage
        tempImage = giverImage.image!
        
        let resizedAndMaskedImage = Toucan(image: tempImage).resize(CGSize(width: 70, height: 70), fitMode: Toucan.Resize.FitMode.Crop).image
        
        giverImage.image = resizedAndMaskedImage
        receiverImage.image = resizedAndMaskedImage
        
        kandiNumDisplay.text = "Kandi #\(braceletSelected)"
        
        print("end of setup")
        
    }
}
