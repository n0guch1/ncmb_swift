//
//  NCMB.swift
//  ncmb_swift
//
//

import UIKit

class NCMB: NSObject {

    static var applicationKey: String  = ""
    static var clientKey: String  = ""
    
    static func initializeKey(applicationKey: String, clientKey: String) {
        NCMB.applicationKey = applicationKey
        NCMB.clientKey = clientKey
    }
}
