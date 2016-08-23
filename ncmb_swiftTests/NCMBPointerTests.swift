//
//  NCMBPointer.swift
//  ncmb_swift
//
//

import XCTest
@testable import ncmb_swift

class NCMBPointerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        let className = "dummyClass"
        let objectId = "dummyId"
        let ncmbPointer = NCMBPointer(className: className ,objectId:objectId)
        XCTAssertEqual(ncmbPointer.className, className)
        XCTAssertEqual(ncmbPointer.objectId, objectId)
    }
    
    func testToDictionary() {
        let className = "dummyClass"
        let objectId = "dummyId"
        let dic = NCMBPointer(className: className,objectId:objectId).toDictionary()
        XCTAssertEqual(dic["className"] as? String, className)
        XCTAssertEqual(dic["objectId"] as? String, objectId)
        XCTAssertEqual(dic["__type"] as? String, "Pointer")
        
        let ncmbPointer = NCMBPointer(params: dic)
        XCTAssertEqual(ncmbPointer.className, className)
        XCTAssertEqual(ncmbPointer.objectId, objectId)
    }

    
}
