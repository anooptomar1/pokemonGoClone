

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController {
  
  var selectedAnnotation: MKAnnotation?
  var targets = [ARItem]()
  let locationManager = CLLocationManager()
  var userLocation: CLLocation?
  

  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
    setupLocations()
    
    if CLLocationManager.authorizationStatus() == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func setupLocations() {
    let firstTarget = ARItem(itemDescription: "wolf", location: CLLocation(latitude: 40.715944, longitude: -73.945096), itemNode: nil)
    targets.append(firstTarget)
    
    let secondTarget = ARItem(itemDescription: "wolf", location: CLLocation(latitude: 40.715879, longitude: -73.945954), itemNode: nil)
    targets.append(secondTarget)
    
    let thirdTarget = ARItem(itemDescription: "dragon", location: CLLocation(latitude: 40.715741, longitude: -73.947477), itemNode: nil)
    targets.append(thirdTarget)
    
    for item in targets {
      let annotation = MapAnnotation(location: item.location.coordinate, item: item)
      self.mapView.addAnnotation(annotation)
      
    }
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    self.userLocation = userLocation.location
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    let coordinate = view.annotation!.coordinate
    
    if let userCoordinate = userLocation {
      
      //sets distance user needs to be from annotation for it to trigger
      if userCoordinate.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) < 50 {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let viewController = storyBoard.instantiateViewController(withIdentifier: "ARViewController") as? ViewController {
         viewController.delegate = self
          
          
          if let mapAnnotation = view.annotation as? MapAnnotation {
            viewController.target = mapAnnotation.item
            viewController.userLocation = mapView.userLocation.location!
            selectedAnnotation = view.annotation
            self.present(viewController, animated:true, completion: nil)
          }
        }
      }
    }
  }
}

extension MapViewController: ARControllerDelegate {
  func viewController(controller: ViewController, tappedTarget: ARItem) {
    self.dismiss(animated: true, completion: nil)
    let index = self.targets.index(where: {$0.itemDescription == tappedTarget.itemDescription})
    
    if selectedAnnotation != nil {
      mapView.removeAnnotation(selectedAnnotation!)
    }
  }
}












































