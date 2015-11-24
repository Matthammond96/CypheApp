
import Foundation
import Alamofire
import SwiftyJSON
import MapKit
import UIKit

class findSpotViewController: UIViewController {
    //Varible
    var logedIn:Double!
    var locationData = [locationDataJSON]()

    //UI Links
    @IBOutlet weak var findSpotMap: MKMapView!
    @IBOutlet weak var locationTables: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logged in?
        if logedIn == 0 {
            performSegueWithIdentifier("notLoggedIn", sender: self)
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
                }
                
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "notLoggedIn" {
            let notLoggedIn = segue.destinationViewController as! loginScreenViewController
            notLoggedIn.logedIn = 0
        }
    }
}

extension findSpotViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //change to array.count
        return locationData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let locationTitleLabel = cell?.viewWithTag(1) as! UILabel
        let locationDescriptionLabel = cell?.viewWithTag(2) as! UILabel
        let ratingLabel = cell?.viewWithTag(3) as! UILabel
        //let distanceLabel = cell?.viewWithTag(4) as! UILabel
        let locationCell = locationData[indexPath.row]
        
        locationTitleLabel.text = locationCell.locationTitleArray
        locationDescriptionLabel.text = locationCell.locationDescriptionArray
        ratingLabel.text = "Avg Rating: \(locationCell.ratingArray)"
        
        return cell!
    }
}

//extension findSpotViewController: UITableViewDelegate {
    
  //  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier(<#T##identifier: String##String#>, sender: self)
  //  }
    
//}





