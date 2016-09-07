//
//  NCMBQuery.swift
//  ncmb_swift
//
//

import UIKit

public class NCMBQuery {
    var query = Dictionary<String, AnyObject>()
    
    public func whereEqualTo(key: String , value: AnyObject) {
        query[key] = value
    }
    
    public func whereNotEqualTo(key: String , value: AnyObject) {
        query[key] = ["$ne":value]
    }
    
    public func whereLessThan(key: String , value: AnyObject) {
        query[key] = ["$lt":value]
    }
    
    public func whereGreaterThan(key: String , value: AnyObject) {
        query[key] = ["$gt":value]
    }
    
    public func whereLessThanOrEqualTo(key: String , value: AnyObject) {
        query[key] = ["$lte":value]
    }
    
    public func whereGreaterThanOrEqualTo(key: String , value: AnyObject) {
        query[key] = ["$gte":value]
    }
    
    public func whereContainedIn(key: String , value: NSArray) {
        query[key] = ["$in":value]
    }

    public func whereNotContainedIn(key: String , value: NSArray) {
        query[key] = ["$nin":value]
    }
    
    public func whereExists(key: String) {
        query[key] = ["$exists":true]
    }
    
    public func whereDoesNotExists(key: String) {
        query[key] = ["$exists":false]
    }
    
    public func whereContainedInArray(key: String, value: NSArray) {
        query[key] = ["$inArray":value]
    }
    
    public func whereNotContainedInArray(key: String, value: NSArray) {
        query[key] = ["$ninArray":value]
    }
    
    public func whereContainsAll(key: String, value: AnyObject) {
        query[key] = ["$all":value]
    }
        
    public func dictionary() -> (Dictionary<String, AnyObject>) {
        return query
    }
}