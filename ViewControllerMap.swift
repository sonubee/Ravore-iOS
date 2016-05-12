//
//  ViewControllerMap.swift
//  Ravore2
//
//  Created by Admin on 5/11/16.
//  Copyright © 2016 G LLC. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewControllerMap: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        for event in allEvents {
            if event.name == festivalSelected {
                let camera = GMSCameraPosition.cameraWithLatitude(event.lat,
                                                                  longitude: event.longi, zoom: 6)
                let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
                mapView.myLocationEnabled = true
                self.view = mapView
                
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake(event.lat, event.longi)
                marker.title = event.name
                marker.snippet = event.location
                marker.map = mapView
            }
        }
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
