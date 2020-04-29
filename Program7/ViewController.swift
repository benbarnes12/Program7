//
//  ViewController.swift
//  Program7
//
//  Created by ben barnes on 4/29/20.
//  Copyright © 2020 ben barnes. All rights reserved.
//

import UIKit
import CoreLocation
import WebKit
import MessageUI
 


class ViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate

 {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }

    
    
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    let locMan: CLLocationManager = CLLocationManager()
       var startLocation: CLLocation!
       
       // Seven Springs
       let springsLatitude: CLLocationDegrees = 0
       let springsLongitude: CLLocationDegrees = 0
    
    // New function to set up GPS
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let newLocation: CLLocation=locations[0]
           NSLog("Something is happening")
    
        // Horizontal accuracy less than 0 means failure with core gps functions
        if newLocation.horizontalAccuracy >= 0 {
          
            
            let springs:CLLocation = CLLocation(latitude: springsLatitude, longitude: springsLongitude)
           
            let delta:CLLocationDistance = springs.distance(from: newLocation)
           
            let miles: Double = (delta * 0.000621371) + 0.5
        
        if miles < 3 {
                          
            // Stop updating the location
                locMan.stopUpdatingLocation()
                
            // Arrival Message
                distanceLabel.text = "Welcome to Seven Springs"
        } else {
            let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
               
               distanceLabel.text=commaDelimited.string(from: NSNumber(value: miles))!+" miles to Seven Springs"
            }
        }
    }
    
    
    @IBOutlet weak var webView: WKWebView!
    
    
    @IBAction func openSite(_ sender: Any) {
        
        
        
         if let url = URL(string: "https://www.7springs.com/")
                      {
               UIApplication.shared.open(url, options: [:])
                      }

    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        
        let composeVC = MFMessageComposeViewController()
                      composeVC.messageComposeDelegate = self
                      
                      // Configure the fields of the interface
                      composeVC.recipients = ["7247195957"]
                      composeVC.body = "Hello"
                      
                      // Present the view controller modally
                      if MFMessageComposeViewController.canSendText() {
                          self.present(composeVC, animated: true, completion: nil)
                      } else {
                          print("Can't send messages")
                      }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Load web content
              let myURL = URL(string:"https://www.apple.com")
              let myRequest = URLRequest(url: myURL!)
                     webView.load(myRequest)
              
              // GPS
              locMan.delegate = self
              locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers
              locMan.distanceFilter = 1609; // A mile in kilometers
              locMan.requestWhenInUseAuthorization()
              locMan.startUpdatingLocation()
              startLocation = nil

        
        
        
    }


}

