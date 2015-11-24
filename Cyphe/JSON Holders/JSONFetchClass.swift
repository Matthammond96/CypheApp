
import Foundation
import CoreLocation
import SwiftyJSON

class locationDataJSON {
    
    var userArray: String!
    var locationTitleArray: String!
    var locationDescriptionArray: String!
    var ratingArray: Double!
    var locationArray: CLLocationCoordinate2D!
    var longitudeArray: Double!
    var latitudeArray: Double!
    
    init(json: JSON) {
        userArray = json["user"].stringValue
        locationTitleArray = json["spotTitle"].stringValue
        locationDescriptionArray = json["description"].stringValue
        ratingArray = json["rating"].doubleValue
        locationArray = CLLocationCoordinate2D(latitude: json["latitude"].doubleValue, longitude: json["longitude"].doubleValue)
    }
    
}