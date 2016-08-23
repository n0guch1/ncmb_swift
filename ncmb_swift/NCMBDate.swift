//
//  NCMBDate.swift
//  ncmb_swift
//
//

import UIKit

public class NCMBDate: NSObject {
    public var date: NSDate = NSDate()
    public static let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    init(date:NSDate){
        self.date = date
    }
    
    init(params:Dictionary<String,AnyObject>){
        super.init()
        
        if(params["iso"] == nil){
            NSException(name: NSInvalidArgumentException, reason: "iso must not nil.", userInfo: nil).raise()
        }
        self.date = dateFromString(params["iso"] as! String)
    }
    
    public func toDictionary() -> (Dictionary<String, AnyObject>) {
        let dic: Dictionary<String, AnyObject> = ["__type": "Date",
                                                  "iso": toString()]
        return (dic)
    }
    
    public func toString() -> (String){
        let iso8601Formatter = NSDateFormatter()
        iso8601Formatter.dateFormat = NCMBDate.dateFormat
        return iso8601Formatter.stringFromDate(self.date)
    }
    
    func dateFromString(dateString:String)  -> (NSDate) {
        let date_formatter: NSDateFormatter = NSDateFormatter()
        date_formatter.dateFormat = NCMBDate.dateFormat
        return date_formatter.dateFromString(dateString)!
    }
}
