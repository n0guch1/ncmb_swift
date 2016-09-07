//
//  NCMBGeoPointTest.swift
//  ncmb_swift
//
//

import XCTest
@testable import ncmb_swift

class NCMBGeoPointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        let latitude = 35.693840
        let longitude = 139.703549
        let ncmbGeoPoint = NCMBGeoPoint(latitude:latitude ,longitude:longitude)
        XCTAssertEqual(ncmbGeoPoint.latitude, latitude)
        XCTAssertEqual(ncmbGeoPoint.longitude, longitude)
    }
    
    func testToDictionary() {
        let latitude = 35.693840
        let longitude = 139.703549
        let dic = NCMBGeoPoint(latitude:latitude ,longitude:longitude).dictionary()
        XCTAssertEqual(dic["latitude"] as? Double, latitude)
        XCTAssertEqual(dic["longitude"] as? Double, longitude)
        XCTAssertEqual(dic["__type"] as? String, "GeoPoint")
        
        let ncmbGeoPoint = NCMBGeoPoint(params: dic)
        XCTAssertEqual(ncmbGeoPoint.latitude, latitude)
        XCTAssertEqual(ncmbGeoPoint.longitude, longitude)
    }
    
}
