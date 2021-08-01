//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by sophia liu on 7/25/21.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, MKMapViewDelegate {

    var region: String = ""
    var mediaURL: String = ""
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setUserInputLocation()
    }
    
    private func setUserInputLocation() {
        let geocoder = CLGeocoder()
              geocoder.geocodeAddressString(region) { placemarks, error in
                  
                guard error == nil else {
                  print("*** Error in \(#function): \(error!.localizedDescription)")
                  return
                }

                guard let placemark = placemarks?[0] else {
                  print("*** Error in \(#function): placemark is nil")
                  return
                }

                guard let location = placemark.location else {
                  print("*** Error in \(#function): placemark is nil")
                  return
                }

                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
            
                let pin = MKPointAnnotation()
                pin.coordinate = center
                self.mapView.addAnnotation(pin)
           }
    }
    
    @IBAction func submitLocation(_ sender: Any) {
        UdacityClient.postStudentInfo() {_,_ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
