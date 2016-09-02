//
//  NCMBQueryTests.swift
//  ncmb_swift
//
//

import XCTest
@testable import ncmb_swift

class NCMBQueryTests: XCTestCase {
    
    func testWhere() {
        let key = "key"
        let query = NCMBQuery()
        
        query.whereEqualTo(key, value: "value")
        XCTAssertEqual(query.toDictionary()[key]?.description, "value")
        
        query.whereNotEqualTo(key, value: "value")
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary, ["$ne":"value"])
        
        query.whereLessThan(key, value: 100)
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary, ["$lt":100])
        
        query.whereGreaterThan(key, value: 50)
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary, ["$gt":50])
        
        query.whereExists(key)
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary, ["$exists":true])
        
        query.whereDoesNotExists(key)
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary, ["$exists":false])
        
        query.whereLessThanOrEqualTo(key, value: 100)
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary, ["$lte":100])

        query.whereGreaterThanOrEqualTo(key, value: 100)
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary,  ["$gte":100])
        
        query.whereContainedIn(key, value: ["A","B","C"])
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary,  ["$in":["A","B","C"]])
        
        query.whereNotContainedIn(key, value: ["A","B","C"])
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary,  ["$nin":["A","B","C"]])
        
        query.whereContainedInArray(key, value: ["A","B","C"])
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary,  ["$inArray":["A","B","C"]])
        
        query.whereNotContainedInArray(key, value: ["A","B","C"])
        XCTAssertEqual(query.toDictionary()[key] as! Dictionary,  ["$ninArray":["A","B","C"]])
    }
    
}
