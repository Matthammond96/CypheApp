
import Foundation
import UIKit
import CoreLocation
import MapKit

class spotClickedViewController: UIViewController {
    
    //Varibles
    var spotData: locationDataJSON!
    var locationManager: CLLocationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var locationLat:Double!
    var locationLong:Double!
    
    
    //IBOutlets
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationDescriptionLabel: UILabel!
    @IBOutlet weak var locationMapKit: MKMapView!
    @IBAction func closeLocationButton(sender: AnyObject) {
        performSegueWithIdentifier("closeLocationSegue", sender: self)
    }
    
    //IBActions
    @IBAction func contentSwitcher(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            locationMapKit.alpha = 1
            imageContainerView.alpha = 0
        } else {
            locationMapKit.alpha = 0
            imageContainerView.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location2D = spotData.locationArray
        locationLat = location2D.latitude
        locationLong = location2D.longitude
        
        locationMapKit.setCenterCoordinate(CLLocationCoordinate2DMake(CLLocationDegrees(locationLat), CLLocationDegrees(locationLong)), animated: true)

        
        let location = CLLocation(latitude: locationLat, longitude: locationLong)
        reverseGeocode(location)
        let annotations = locationMapKit.annotations
        
        locationTitleLabel.text = spotData.locationTitleArray
        locationDescriptionLabel.text = spotData.locationDescriptionArray
        
        print(spotData.locationTitleArray)
        print(spotData.locationDescriptionArray)
        print(spotData.ratingArray)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    func reverseGeocode(location: CLLocation) {
        if !geocoder.geocoding {
            geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse Geocoding failed with error" + error!.localizedDescription)
                    return
                }
                if placemarks!.count > 0 {
                    if let placemark = placemarks!.first {
                        print(placemark.country)
                        
                        var annotationTitle = self.spotData.locationTitleArray
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(self.locationLat), CLLocationDegrees(self.locationLong))
                        annotation.title = annotationTitle
                        self.locationMapKit.addAnnotation(annotation)
                        self.locationMapKit.selectAnnotation(annotation, animated: true)
                        
                    }
                } else {
                    print("Prolbem with data recieved from Geocoder")
                }
            })
        } else {
            print("Geocoding is already geocoding")
            return
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "closeLocationSegue" {
            let closeLocation = segue.destinationViewController as! SWRevealViewController
        }
    }
    
}

extension spotClickedViewController: CLLocationManagerDelegate {
    
   
}










