//
//  NCMBDate.swift
//  ncmb_swift
//
//

import UIKit

public class NCMBDate {
    
    public var date: NSDate = NSDate()
    
    init(date:NSDate){
        self.date = date
    }
    
    init(dateString:String){
        self.date = NCMBDate.iso8601Formatter().dateFromString(dateString)!
    }
    
    init(params:Dictionary<String,AnyObject>){
        if(params["iso"] == nil){
            NSException(name: NSInvalidArgumentException, reason: "iso must not nil.", userInfo: nil).raise()
        }
        self.date = self.dateFromString(params["iso"] as! String)
    }
    
    public func toDictionary() -> (Dictionary<String, AnyObject>) {
        let dic: Dictionary<String, AnyObject> = ["__type": "Date",
                                                  "iso": description()]
        return dic
    }
    
    public func description() -> (String){
        return NCMBDate.iso8601Formatter().stringFromDate(self.date)
    }
    
    public static func iso8601Formatter() -> (NSDateFormatter){
        let iso8601Formatter = NSDateFormatter()
        iso8601Formatter.timeZone = NSTimeZone.localTimeZone()
        iso8601Formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return iso8601Formatter
    }
    
    func dateFromString(dateString: String)  -> (NSDate) {
        return NCMBDate.iso8601Formatter().dateFromString(dateString)!
    }
}
