//
//  AccountVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 2.05.2023.
//

import UIKit
import SnapKit
import MapKit

class AccountVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()



    var userNumber = UILabel()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Set up map view
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.frame = view.bounds
        view.addSubview(mapView)
        
        view.backgroundColor = .white
        view.addSubview(userNumber)

        userNumber.textAlignment = .center
        let vc = ViewController()
        vc.completionHandler = {text in
            self.userNumber.text = text
        }
        userNumber.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }

    }
    func getAddress(from location: CLLocation, completion: @escaping (String?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                completion(nil, error)
            } else if let placemark = placemarks?.first {
                let address = [placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode, placemark.country].compactMap({ $0 }).joined(separator: ", ")
                completion(address, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Set map region to the user's location
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        // Add a draggable annotation at the user's location
        addDraggableAnnotation(at: location.coordinate)
        
        // Stop updating the user's location to prevent constant updates
        locationManager.stopUpdatingLocation()

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
    func addDraggableAnnotation(at coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Drag to change location"
        mapView.addAnnotation(annotation)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil // Use the default view for the user's location
        }
        
        let reuseIdentifier = "DraggableAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
            annotationView?.isDraggable = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            let droppedCoordinate = view.annotation?.coordinate
            let droppedLocation = CLLocation(latitude: droppedCoordinate?.latitude ?? 0, longitude: droppedCoordinate?.longitude ?? 0)
            
            // Get the address for the dropped location
            getAddress(from: droppedLocation) { (address, error) in
                if let address = address {
                    print("Dropped location address: \(address)")
                } else {
                    print("Error getting address: \(error?.localizedDescription ?? "unknown error")")
                }
            }
        }
    }


    



    

    



}
