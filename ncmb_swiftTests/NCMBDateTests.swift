//
//  NCMBDateTests.swift
//  ncmb_swift
//
//

import XCTest
@testable import ncmb_swift

class NCMBDateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        let date = NSDate()
        let ncmbDate = NCMBDate(date: date)
        XCTAssertEqual(ncmbDate.date, date)
    }
    
    func testToDictionary() {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss.SSS"
        let date = formatter.dateFromString("2016/01/01 12:34:56.789")!
        
        let dic = NCMBDate(date: date).toDictionary()
        XCTAssertEqual(dic["iso"] as? String, "2016-01-01T12:34:56.789Z")
        XCTAssertEqual(dic["__type"] as? String, "Date")
        
        let ncmbDate = NCMBDate(params: dic)
        XCTAssertEqual(ncmbDate.date, date)
    }
    
}
