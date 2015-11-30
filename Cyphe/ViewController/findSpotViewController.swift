
import Foundation
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
import UIKit

class findSpotViewController: UIViewController {
    //Varible
    var logedIn:Double!
    var locationData = [locationDataJSON]()
    var selectedCell: locationDataJSON!
    var testLocation = CLLocationCoordinate2D(latitude: 50, longitude: 50)
    var locationManager: CLLocationManager = CLLocationManager()
    var userCLLocation: CLLocation!
    
    //UI Links
    @IBOutlet weak var findSpotMap: MKMapView!
    @IBOutlet weak var locationTables: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var newLocationButton: UIBarButtonItem!
    
    @IBAction func addLocation(sender: AnyObject) {
        performSegueWithIdentifier("addLocationSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserInfo.userName)
        
        findSpotMap.setUserTrackingMode(.Follow, animated: true)
    
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            newLocationButton.target = self.revealViewController()
            newLocationButton.action = "rightRevealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        Alamofire.request(.GET, "http://woamph.com/savedLocations.json")
            .response { request, response, data, error in
        
                if let data = data {
                    let json = JSON(data:data)
                    
                    for metaInfoJson in json {
                        let metaInfo = locationDataJSON(json: metaInfoJson.1)
                        self.locationData.append(metaInfo)
                        self.locationTables.reloadData()
                    }
                    
                    for location in self.locationData {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(location.locationArray.latitude), CLLocationDegrees(location.locationArray.longitude))
                        self.findSpotMap.addAnnotation(annotation)
                    }
                }
                
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "notLoggedIn" {
            let notLoggedIn = segue.destinationViewController as! loginScreenViewController
            notLoggedIn.logedIn = 0
        }
        if segue.identifier == "cellSelected" {
            let selectedLocationVC = segue.destinationViewController as! spotClickedViewController
            selectedLocationVC.spotData = selectedCell!
        }
    }
}

extension findSpotViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[locations.count - 1]
        userCLLocation = userLocation
        locationTables.reloadData()
    }
}

extension findSpotViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //change to array.count
        return locationData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = locationTables.dequeueReusableCellWithIdentifier("Cell")
        let locationTitleLabel = cell?.viewWithTag(1) as! UILabel
        let locationDescriptionLabel = cell?.viewWithTag(2) as! UILabel
        let ratingLabel = cell?.viewWithTag(3) as! UILabel
        let distanceLabel = cell?.viewWithTag(4) as! UILabel
        let locationCell = locationData[indexPath.row]
        let locationsLocation = locationCell.locationArray
        let locationCLLocation = CLLocation(latitude: locationsLocation.latitude, longitude: locationsLocation.longitude)
        
        if userCLLocation == nil {
            print("Location Needed")
            distanceLabel.text = "Distance: User Location Needed!"
        } else {
            let distanceMaths: CLLocationDistance = (locationCLLocation.distanceFromLocation(userCLLocation)) / 1000
            
            distanceLabel.text = "Distance: \(Double(distanceMaths).roundToPlaces(1) )km"
        
            if distanceMaths < 10 {
                locationTitleLabel.text = locationCell.locationTitleArray
                locationDescriptionLabel.text = locationCell.locationDescriptionArray
                ratingLabel.text = "Avg Rating: \(locationCell.ratingArray)"
            }
        }
        
        return cell!
    }
}

extension findSpotViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell = locationData[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("cellSelected", sender: self)
    }
}