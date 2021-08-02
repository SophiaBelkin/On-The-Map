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
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
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

                self.latitude = location.coordinate.latitude
                self.longitude = location.coordinate.longitude
                let center = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                self.mapView.setRegion(region, animated: true)
            
                let pin = MKPointAnnotation()
                pin.coordinate = center
                self.mapView.addAnnotation(pin)
           }
    }
    
    @IBAction func submitLocation(_ sender: Any) {
        UdacityClient.postStudentInfo(mapString: region, mediaURL: mediaURL, latitude: latitude, longitude: longitude) { response, error in
            if response{
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.showFailedMessage(title: "Failed to save your location", message: error?.localizedDescription ?? "")
            }
        }
    }
    
}
