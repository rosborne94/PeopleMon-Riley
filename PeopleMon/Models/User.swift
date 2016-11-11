//
//  User.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/2/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

// Just a test object to excercise the network stack
class User : NetworkModel {
    /*{
     "Id": "string",
     "Email": "string",
     "HasRegistered": true,
     "LoginProvider": "string",
     "FullName": "string",
     "AvatarBase64": "string",
     "LastCheckInLongitude": 0,
     "LastCheckInLatitude": 0,
     "LastCheckInDateTime": "2016-11-07T01:11:03.917Z"
     }*/
    
    var id : String?
    var email : String?
    var username : String?
    var hasRegistered : String?
    var  loginProvider : String?
    var  avatarBase64 : String?
    var lastCheckInLongitude : Int?
    var  lastCheckInLatitude : Int?
    var lastCheckInDateTime : String?
    var fullName : String?
    var oldPassword : String?
    var newPassword : String?
    var confirmPassword : String?
    var apiKey : String?
    var password : String?
    var token : String?
    var expiration : String?
    var image : UIImage?
    
    // Request Type
    enum RequestType {
        case userInfo
        case changePassword
        case setPassword
        case register
        case login
    }
    var requestType = RequestType.userInfo
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.User.token)
        expiration = try? json.getString(at: Constants.User.expiration)
        
        id = try? json.getString(at: Constants.User.id)
        email = try? json.getString(at: Constants.User.email)
        fullName = try? json.getString(at: Constants.User.fullName)
        lastCheckInLongitude = try? json.getInt(at: Constants.User.lastCheckInLongitude)
        lastCheckInLatitude = try? json.getInt(at: Constants.User.lastCheckInLatitude)
        fullName = try? json.getString(at: Constants.User.fullName)
        loginProvider = try? json.getString(at: Constants.User.loginProvider)
        hasRegistered = try? json.getString(at: Constants.User.hasRegistered)
    }
    
    init(fullName: String, avatarBase64: String) {
        self.fullName = fullName
        self.avatarBase64 = avatarBase64
        requestType = .userInfo
    }
    
    init (email: String, password: String){
        self.email = email
        self.password = password
        requestType = .login
    }
    
    init(oldPassword: String, newPassword: String, confirmPassword: String) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.confirmPassword = confirmPassword
        requestType = .changePassword
    }
    
    init(password: String) {
        self.password = password
        requestType = .setPassword
    }
    
    init(email: String, password: String, fullName: String) {
        self.email = email
        self.password = password
        self.fullName = fullName
        self.apiKey = Constants.apiKey
        requestType = .register
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch  requestType {
        case .userInfo:
           return .get
        default:
            return .post
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .userInfo:
            return "/api/Account/UserInfo"
        case .changePassword:
            return "/api/Account/ChangePassword"
        case .setPassword:
            return "/api/Account/SetPassword"
        case .register:
            return "/api/Account/Register"
        case .login:
            return "/token"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        
        switch requestType {
        case .register:
            params[Constants.User.email] = email as AnyObject?
            params[Constants.User.fullName] = fullName as AnyObject?
            params[Constants.User.avatarBase64] = avatarBase64 as AnyObject?
            params[Constants.User.apiKey] = Constants.apiKey as AnyObject?
            params[Constants.User.password] = password as AnyObject?
        case .login:
            params[Constants.User.grantType] = Constants.User.password as AnyObject?
            params[Constants.User.userName] = email as AnyObject?
            params[Constants.User.password] = password as AnyObject?
        default:
            break
        }
        
        return params
    }
    
}
