//
//  ncmb_swiftTests.swift
//  ncmb_swiftTests
//
//

import XCTest
@testable import ncmb_swift

class ncmb_swiftTests: XCTestCase {
    
    var applicationKey: String  = "dummyApplicationKey"
    var clientKey: String  = "dummyClientKey"
    
    
    override func setUp() {
        super.setUp()
        NCMB.initializeKey(self.applicationKey,clientKey: self.clientKey)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitializeKey() {
        XCTAssertEqual(NCMB.applicationKey, self.applicationKey)
        XCTAssertEqual(NCMB.clientKey, self.clientKey)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
