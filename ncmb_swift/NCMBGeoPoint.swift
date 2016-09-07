//
//  NCMBGeopoint.swift
//  ncmb_swift
//
//

import UIKit

public class NCMBGeoPoint {
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
    
    init(latitude: Double, longitude: Double){
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(params: Dictionary<String,AnyObject>){
        if params["latitude"] == nil && params["longitude"] == nil {
            NSException(name: NSInvalidArgumentException, reason: "latitude or longitude must not nil.", userInfo: nil).raise()
        }
        self.latitude = params["latitude"] as! Double
        self.longitude = params["longitude"] as! Double
    }
    
    public func toDictionary() -> (Dictionary<String, AnyObject>) {
        let dic: Dictionary<String, AnyObject> = ["__type": "GeoPoint",
                                               "longitude": self.longitude,
                                               "latitude": self.latitude]
        return dic
    }
}
