//
//  NCMBRequestTests.swift
//  ncmb_swift
//
//

import XCTest

class NCMBRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // テスト用キー
        NCMB.initializeKey("applicationKey",
                           clientKey: "clientKey")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateSignature() {
        // ドキュメント公開用APIKey
        NCMB.initializeKey("6145f91061916580c742f806bab67649d10f45920246ff459404c46f00ff3e56",
                           clientKey: "1343d198b510a0315db1c03f3aa0e32418b7a743f8e4b47cbff670601345cf75")
        
        let url = NSURL(string: "https://mb.api.cloud.nifty.com/2013-09-01/classes/TestClass")!
        let reqest = NCMBRequest(URL: url)
        reqest.HTTPMethod = "GET"
        reqest.HTTPTimestamp = "2013-12-02T02:44:35.452Z"
        let query = NCMBQuery()
        query.whereEqualTo("testKey", value: "testValue")
        reqest.HTTPQuery = query
        
        XCTAssertEqual("/mQAJJfMHx2XN9mPZ9bDWR9VIeftZ97ntzDIRw0MQ4M=", reqest.createSignature())
    }
    
    // 非同期 POST
    func testAsyncConnection() {
        let url = NSURL(string: "https://mb.api.cloud.nifty.com/2013-09-01/classes/TestClass")!
        let request = NCMBRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPSignature = request.createSignature()
        request.HTTPBody = "{\"key\":\"value\"}".dataUsingEncoding(NSUTF8StringEncoding)
        let connectionExpectation: XCTestExpectation? = self.expectationWithDescription("connection test")
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            XCTAssertNil(error)
            // データ取得
            let myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            XCTAssertNotNil(myData)
            // 非同期完了
            connectionExpectation?.fulfill()
        }
        // 非同期待ち
        waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    // 同期 GET
    func testSyncConnection() {
        let url = NSURL(string: "https://mb.api.cloud.nifty.com/2013-09-01/classes/TestClass")!
        let request = NCMBRequest(URL: url)
        request.HTTPMethod = "GET"
        request.HTTPSignature = request.createSignature()
        var response: NSURLResponse?
        var data = NSData()
        do {
            data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            if let httpResponse = response as? NSHTTPURLResponse {
                XCTAssertEqual(200, httpResponse.statusCode)
            }
        } catch (let e) {
            XCTAssertThrowsError(e)
        }
        let myData:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        XCTAssertNotNil(myData)
    }
    
    func testQueryConnection() {
        let url = NSURL(string: "https://mb.api.cloud.nifty.com/2013-09-01/classes/TestClass")!
        let request = NCMBRequest(URL: url)
        request.HTTPMethod = "GET"
        let query = NCMBQuery()
        query.whereEqualTo("key", value: "value")
        request.HTTPQuery = query
        request.HTTPSignature = request.createSignature()
        let connectionExpectation: XCTestExpectation? = self.expectationWithDescription("connection test")
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            XCTAssertNil(error)
            
            let myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            XCTAssertNotNil(myData)
            connectionExpectation?.fulfill()
        }
        waitForExpectationsWithTimeout(10.0, handler: nil)
    }

    func  testHeaders() {
        let request = NCMBRequest(URL: NSURL(string: "https://mb.api.cloud.nifty.com/2013-09-01/classes/TestClass")!)
        let headers = request.allHTTPHeaderFields
        XCTAssertEqual(headers!["X-NCMB-Application-Key"], NCMB.applicationKey)
        XCTAssertEqual(headers!["Content-Type"], request.HTTPContentType)
        XCTAssertNotNil(headers!["X-NCMB-Timestamp"], request.HTTPTimestamp)
        XCTAssertNotNil(headers!["X-NCMB-OS-Version"], UIDevice.currentDevice().systemVersion)
        XCTAssertNotNil(headers!["X-NCMB-SDK-Version"], NCMB.sdkVersion)
    }
}
