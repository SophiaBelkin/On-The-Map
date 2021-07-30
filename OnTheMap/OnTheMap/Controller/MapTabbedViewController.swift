//
//  MapViewController.swift
//  OnTheMap
//
//  Created by sophia liu on 7/25/21.
//

import UIKit
import MapKit

class MapTabbedViewController: UIViewController {


    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        UdacityClient.getStudentsInfo { data, error in
            Global.studentsInfo = data
            let annotations = self.getAnnotations(studentsInfo: Global.studentsInfo)
            DispatchQueue.main.async {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
    
    
    private func getAnnotations(studentsInfo: [StudentInfo]) -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for dictionary in studentsInfo {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(dictionary.latitude)
            let long = CLLocationDegrees(dictionary.longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        return annotations
    }

    @IBAction func refreshData(_ sender: Any) {
        UdacityClient.getStudentsInfo { data, error in
            Global.studentsInfo = data
            let annotations = self.getAnnotations(studentsInfo: Global.studentsInfo)
            DispatchQueue.main.async {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
        
    @IBAction func logout(_ sender: Any) {
        UdacityClient.logout() { _,_  in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
       
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InfoPostingViewController") as! InfoPostingViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension MapTabbedViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let subtitle = view.annotation?.subtitle,
               let link = subtitle,
               let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
    }
}
