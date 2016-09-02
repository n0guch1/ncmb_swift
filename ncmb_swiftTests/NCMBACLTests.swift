//
//  NCMBACLTest.swift
//  ncmb_swift
//
//

import XCTest
@testable import ncmb_swift

class NCMBACLTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetAccess() {
        let acl = NCMBACL()
        
        // public permission
        acl.setPublicReadAccess(true)
        acl.setPublicWriteAccess(true)
        XCTAssertTrue(acl.isPublicReadAccess())
        XCTAssertTrue(acl.isPublicWriteAccess())
        
        acl.setPublicReadAccess(false)
        acl.setPublicWriteAccess(false)
        XCTAssertFalse(acl.isPublicReadAccess())
        XCTAssertFalse(acl.isPublicWriteAccess())
        
        // user permission
        let objectId = "dummyObjectId"
        acl.setUserReadAccess(objectId, allowed: true)
        acl.setUserWriteAccess(objectId, allowed: true)
        XCTAssertTrue(acl.isUserReadAccess(objectId))
        XCTAssertTrue(acl.isUserWriteAccess(objectId))
        
        acl.setUserReadAccess(objectId, allowed: false)
        acl.setUserWriteAccess(objectId, allowed: false)
        XCTAssertFalse(acl.isUserReadAccess(objectId))
        XCTAssertFalse(acl.isUserWriteAccess(objectId))
        
        // role permission
        let roleName = "roleName"
        acl.setRoleReadAccess(roleName, allowed: true)
        acl.setRoleWriteAccess(roleName, allowed: true)
        XCTAssertTrue(acl.isRoleReadAccess(roleName))
        XCTAssertTrue(acl.isRoleWriteAccess(roleName))
        
        acl.setRoleReadAccess(roleName, allowed: false)
        acl.setRoleWriteAccess(roleName, allowed: false)
        XCTAssertFalse(acl.isRoleReadAccess(roleName))
        XCTAssertFalse(acl.isRoleWriteAccess(roleName))
    }
    
    func testToDictionary() {
        let objectId = "dummyObjectId"
        var acl = NCMBACL()
        acl.setPublicReadAccess(true)
        acl.setUserWriteAccess(objectId, allowed: true)
        var dic = acl.toDictionary()
        XCTAssertEqual(dic["acl"]!["*"]!["read"], true)
        XCTAssertEqual(dic["acl"]![objectId]!["write"], true)

        acl = NCMBACL(params: dic)
        XCTAssertTrue(acl.isPublicReadAccess())
        XCTAssertTrue(acl.isUserWriteAccess(objectId))
    }
}
