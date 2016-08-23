//
//  NCMBPointer.swift
//  ncmb_swift
//
//

import UIKit

public class NCMBPointer: NSObject {
    public var className: String  = ""
    public var objectId: String  = ""
    
    init(className:String, objectId:String){
        self.className = className
        self.objectId = objectId
    }
    
    init(params:Dictionary<String,AnyObject>){
        if(params["className"] == nil && params["objectId"] == nil){
            NSException(name: NSInvalidArgumentException, reason: "className or objectId must not nil.", userInfo: nil).raise()
        }
        self.className = params["className"] as! String
        self.objectId = params["objectId"]as! String
    }
    
    public func toDictionary() -> (Dictionary<String, AnyObject>) {
        let dic: Dictionary<String, AnyObject> = ["__type": "Pointer",
                                                          "className": self.className,
                                                          "objectId":self.objectId]
        return (dic)
    }
    
}
