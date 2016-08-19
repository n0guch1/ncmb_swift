//
//  NCMB.swift
//  ncmb_swift
//
//

import UIKit

public class NCMB: NSObject {

    public static var applicationKey: String  = ""
    public static var clientKey: String  = ""
    
    public static func initializeKey(applicationKey: String, clientKey: String) {
        NCMB.applicationKey = applicationKey
        NCMB.clientKey = clientKey
    }
}
