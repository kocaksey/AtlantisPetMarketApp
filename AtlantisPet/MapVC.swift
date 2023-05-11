//
//  MapVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 3.05.2023.
//

import UIKit
import SnapKit
import MapKit
import CoreData
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let geocoder = CLGeocoder()
    var selectedLocation: CLLocation?
    var selectedAddress: String?
    let annotation = MKPointAnnotation()
    let centerAnnotation = MKPointAnnotation()


    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    var chosenLocation: CLLocationCoordinate2D?
    var chosenAddress: String?

    var userNumber = UILabel()
    
    // In your ViewController class




    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        setupOKButton()


        addDraggableAnnotation(at: mapView.centerCoordinate)
        addCenterAnnotation()

        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Set up map view
        mapView.delegate = self
        mapView.showsUserLocation = true
//        mapView.frame = view.bounds
        
//        view.addSubview(userNumber)


//        userNumber.textAlignment = .center
//        let vc = ViewController()
//        vc.completionHandler = {text in
//            self.userNumber.text = text
//        }
//        userNumber.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(200)
//            make.leading.equalToSuperview().offset(100)
//            make.trailing.equalToSuperview().inset(100)
//            make.height.equalTo(50)
//        }
        


    }
    


    func setupOKButton() {
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        okButton.frame = CGRect(x: view.bounds.width - 70, y: view.bounds.height - 100, width: 50, height: 30)
        mapView.addSubview(okButton)
    }

    
    
    func saveLocationToCoreData(latitude: Double, longitude: Double, address: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let locationEntity = NSEntityDescription.entity(forEntityName: "Location", in: context)!
        let location = NSManagedObject(entity: locationEntity, insertInto: context)
        
        location.setValue(latitude, forKey: "latitude")
        location.setValue(longitude, forKey: "longitude")
        location.setValue(address, forKey: "address")
        
        do {
            try context.save()
            print("Location and address saved to Core Data")
//            dismiss(animated: true)
        } catch let error as NSError {
            print("Could not save location and address. \(error), \(error.userInfo)")
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
    @objc func okButtonTapped() {
        let centerCoordinate = mapView.centerCoordinate
        let location = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        
        // Reverse geocode the coordinate
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error reverse geocoding: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                // Get the address from the placemark
                let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                
                // Save location and address to Core Data
                self.saveLocationToCoreData(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude, address: address)
            }
        }
    }


    

    func updateLocationInformation() {
        let centerCoordinate = mapView.centerCoordinate
        annotation.coordinate = centerCoordinate
        
        let location = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        
        // Reverse geocode the coordinate
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error reverse geocoding: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                // Get the address from the placemark
                let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                
                // Update the selectedLocation and selectedAddress variables
                self.selectedLocation = location
                self.selectedAddress = address
                
                print("Selected location: \(location)")
                print("Selected address: \(address)")
            }
        }
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapView.removeAnnotation(centerAnnotation)
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
        annotation.coordinate = coordinate
        annotation.title = "Drag to change location"
        mapView.addAnnotation(annotation)
    
    }
    func addCenterAnnotation() {
        centerAnnotation.coordinate = mapView.centerCoordinate
        centerAnnotation.title = "Drag to change location"
        mapView.addAnnotation(centerAnnotation)
    }

func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKPointAnnotation {
        let reuseIdentifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? CustomAnnotation
        
        if annotationView == nil {
            annotationView = CustomAnnotation(annotation: annotation, reuseIdentifier: reuseIdentifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    return nil
}

    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.addAnnotation(centerAnnotation)

        updateLocationInformation()

    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            let droppedCoordinate = view.annotation?.coordinate
            let droppedLocation = CLLocation(latitude: droppedCoordinate?.latitude ?? 0, longitude: droppedCoordinate?.longitude ?? 0)
            
            chosenLocation = droppedCoordinate

            // Get the address for the dropped location
            getAddress(from: droppedLocation) { (address, error) in
                if let address = address {
                    print("Dropped location address: \(address)")
                } else {
                    print("Error getting address: \(error?.localizedDescription ?? "unknown error")")
                }
            }
        }
        
        if let chosenLocation = chosenLocation {
            print("Chosen location coordinates: \(chosenLocation.latitude), \(chosenLocation.longitude)")
        } else {
            print("No chosen location")
        }
    }

}



