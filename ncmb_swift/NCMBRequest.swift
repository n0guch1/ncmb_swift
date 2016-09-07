//
//  NCMBRequest.swift
//  ncmb_swift
//
//

import UIKit
import Foundation
import CryptoSwift

public class NCMBRequest: NSMutableURLRequest {
    
    public let fqdn: String = "mb.api.cloud.nifty.com"
    public let signatureMethod: String = "SignatureMethod=HmacSHA256"
    public let signatureVersion: String = "SignatureVersion=2"
    public let headerApplicationKey: String = "X-NCMB-Application-Key"
    public let headerSignatureKey: String = "X-NCMB-Signature"
    public let headerTimestampKey: String = "X-NCMB-Timestamp"
    public let headerSessionTokenKey: String = "X-NCMB-Apps-Session-Token"
    public let headerSdkVersionKey: String = "X-NCMB-SDK-Version"
    public let headerOsVersion: String = "X-NCMB-OS-Version"
    public let headerContentTypeKey: String = "Content-Type"
    public let headerContentTypeJson: String = "application/json"
    public let headerContentTypeFormData: String = "multipart/form-data"
    
    var query: NCMBQuery!
    var queryString: String!
    var timestampString: String!
    
    convenience init(URL:NSURL) {
        self.init(URL: URL, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData)
    }
    
    convenience init(URL:NSURL,cachePolicy:NSURLRequestCachePolicy) {
        self.init(URL: URL ,cachePolicy:cachePolicy, timeoutInterval: 10.0)
    }
    
    override init(URL:NSURL,cachePolicy:NSURLRequestCachePolicy,timeoutInterval: NSTimeInterval) {
        super.init(URL: URL, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,timeoutInterval: timeoutInterval)
        setDefaultHeaders()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDefaultHeaders() {
        setValue(NCMB.applicationKey, forHTTPHeaderField: self.headerApplicationKey)
        setValue("swift-" + NCMB.sdkVersion, forHTTPHeaderField: self.headerSdkVersionKey)
        setValue(UIDevice.currentDevice().systemVersion, forHTTPHeaderField: self.headerOsVersion)
        // デフォルト現在時刻を設定
        self.timestampString = NCMBDate(date: NSDate()).description()
        setValue(self.timestampString, forHTTPHeaderField: self.headerTimestampKey)
        // デフォルトapplication/jsonを設定
        setValue(self.headerContentTypeJson, forHTTPHeaderField: self.headerContentTypeKey)
    }
    
    public var HTTPContentType: String {
        get {
            return allHTTPHeaderFields![headerContentTypeKey]!
        }
        set(value) {
            setValue(value, forHTTPHeaderField: self.headerContentTypeKey)
        }
    }
    
    public var HTTPTimestamp: String {
        get {
            let dateString = allHTTPHeaderFields![headerTimestampKey]!
            return dateString
        }
        set(value) {
            self.timestampString = NCMBDate(dateString: value).description()
            setValue(self.timestampString, forHTTPHeaderField: self.headerTimestampKey)
        }
    }
    
    public var HTTPSessionToken: String {
        get {
            var result = ""
            if allHTTPHeaderFields?.keys.contains(headerSessionTokenKey) == true {
                result = allHTTPHeaderFields![headerSessionTokenKey]!
            }
            return result
        }
        set(value) {
            setValue(value, forHTTPHeaderField: self.headerSessionTokenKey)
        }
    }
    
    public var HTTPSignature: String {
        get {
            var result = ""
            if allHTTPHeaderFields?.keys.contains(headerSignatureKey) == true{
                result = allHTTPHeaderFields![headerSignatureKey]!
            }
            return result
        }
        set(value) {
            setValue(value, forHTTPHeaderField: self.headerSignatureKey)
        }
    }
    
    public var HTTPQuery: NCMBQuery {
        get {
            return self.query
        }
        set(value) {
            self.query = value
            self.queryString = createQueryString(self.query)
        }
    }
    
    func createQueryString(query: NCMBQuery) -> String {
        var queryStr = ""
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(query.toDictionary(), options:  NSJSONWritingOptions.init(rawValue: 0))
            let jsonString = String(data:jsonData, encoding:NSUTF8StringEncoding)!
            queryStr = "where=" + jsonString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
            URL = NSURL(string: (URL?.absoluteString)! + "?" + queryStr)
        } catch let error as NSError {
            NSException(name: NSInvalidArgumentException, reason: error.localizedDescription, userInfo: error.userInfo).raise()
        }
        return queryStr
    }
    
    public func createSignature() -> String {
        //シグネチャ生成用文字列を作成
        var signatureDataString = HTTPMethod + "\n"
        signatureDataString += self.fqdn + "\n"
        signatureDataString += URL!.path! + "\n"
        signatureDataString += self.signatureMethod + "&"
        signatureDataString += self.signatureVersion + "&"
        signatureDataString += self.headerApplicationKey + "=" + NCMB.applicationKey + "&"
        signatureDataString += self.headerTimestampKey + "=" + self.timestampString
        if self.query != nil {
            signatureDataString += "&" + self.queryString
        }
        
        //SHA256でハッシュ化
        let clientKeyByte: [UInt8] = (NCMB.clientKey.dataUsingEncoding(NSUTF8StringEncoding)?.arrayOfBytes())!
        let authenticator:Authenticator = Authenticator.HMAC(key: clientKeyByte, variant: HMAC.Variant.sha256)
        let message = signatureDataString.dataUsingEncoding(NSUTF8StringEncoding)
        let signatureDataByte = try! authenticator.authenticate((message?.arrayOfBytes())!)
        
        //base64でエンコード
        let signatureData = NSData(bytes: signatureDataByte)
        let signature = signatureData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.EncodingEndLineWithLineFeed)
        return signature
    }
}
