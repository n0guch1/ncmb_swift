//
//  NCMBACL.swift
//  ncmb_swift
//
//

import UIKit

public class NCMBACL {
    
    public static let publicPermissionKey: String = "*"
    public static let rolePermissionKey: String = "role:"
    public static let readKey: String = "read"
    public static let writeKey: String = "write"
    
    public var permissions = Dictionary<String, Dictionary<String,Bool>>()
    
    init(){
    }
    
    init(params: Dictionary<String, Dictionary<String,Dictionary<String,Bool>>>){
        if(params["acl"] == nil){
            NSException(name: NSInvalidArgumentException, reason: "acl must not nil.", userInfo: nil).raise()
        }
        self.permissions = params["acl"]!
    }
    
    public func setPublicReadAccess(allowed: Bool){
        set(NCMBACL.publicPermissionKey, type: NCMBACL.readKey , allowed: allowed)
    }
    
    public func setPublicWriteAccess(allowed: Bool){
        set(NCMBACL.publicPermissionKey, type: NCMBACL.writeKey , allowed: allowed)
    }
    
    public func setRoleReadAccess(roleName: String ,allowed: Bool){
        set(NCMBACL.rolePermissionKey + roleName, type: NCMBACL.readKey , allowed: allowed)
    }
    
    public func setRoleWriteAccess(roleName: String ,allowed: Bool){
        set(NCMBACL.rolePermissionKey + roleName, type: NCMBACL.writeKey , allowed: allowed)
    }
    
    public func setUserReadAccess(objectId: String ,allowed: Bool){
        set(objectId, type:NCMBACL.readKey , allowed: allowed)
    }
    
    public func setUserWriteAccess(objectId: String ,allowed: Bool){
        set(objectId, type:NCMBACL.writeKey , allowed: allowed)
    }
    
    public func isPublicReadAccess() -> Bool{
        return get(NCMBACL.publicPermissionKey, type: NCMBACL.readKey)
    }
    
    public func isPublicWriteAccess() -> Bool{
        return get(NCMBACL.publicPermissionKey, type: NCMBACL.writeKey)
    }
    
    public func isRoleReadAccess(roleName: String) -> Bool{
        return get(NCMBACL.rolePermissionKey + roleName, type: NCMBACL.readKey)
    }
    
    public func isRoleWriteAccess(roleName: String) -> Bool{
        return get(NCMBACL.rolePermissionKey + roleName, type: NCMBACL.writeKey)
    }
    
    public func isUserReadAccess(objectId: String) -> Bool{
        return get(objectId, type:NCMBACL.readKey)
    }
    
    public func isUserWriteAccess(objectId: String) -> Bool{
        return get(objectId, type:NCMBACL.writeKey)
    }
    
    public func dictionary() -> Dictionary<String, Dictionary<String,Dictionary<String,Bool>>> {
        let dic = ["acl": self.permissions]
        return dic
    }
    
    func get(target: String,type: String) -> Bool{
        var allowed = false
        if self.permissions[target] != nil && self.permissions[target]![type] != nil{
            allowed = true
        }
        return allowed
    }
    
    func set(target: String ,type: String, allowed: Bool){
        if allowed {
            if self.permissions[target] == nil{
                self.permissions[target] = [type: allowed]
            }else {
                self.permissions[target]![type] = allowed
            }
        }else{
            if self.permissions[target] != nil{
                self.permissions[target]?.removeValueForKey(type)
                if self.permissions[target]?.count == 0 {
                    self.permissions.removeValueForKey(target)
                }
            }
        }
    }
}
