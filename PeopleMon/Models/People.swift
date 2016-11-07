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
class People : NetworkModel {
    
    var userId : String?
    var userName : String?
    var avatarBase64 : String?
    var  longitude : Int?
    var  latitude : Int?
    var created : String?
    var  caughtUserId : String?
    var  radiusInMeters : Int?
   
    // Request Type
    enum RequestType {
        case userCheckIn
        case userCatch
    }
    var requestType = RequestType.userCheckIn
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        userId = try? json.getString(at: Constants.People.userId)
        userName = try? json.getString(at: Constants.People.userName)
        avatarBase64 = try? json.getString(at: Constants.People.avatarBase64)
        longitude = try? json.getInt(at: Constants.People.longitude)
        latitude = try? json.getInt(at: Constants.People.latitude)
        created = try? json.getString(at: Constants.People.created)
    }
    
    init(longitude: Int, latitude: Int) {
        self.longitude = longitude
        self.latitude = latitude
        requestType = .userCheckIn
    }
    
    init(caughtUserId: String, radiusInMeters: Int) {
        self.caughtUserId = caughtUserId
        self.radiusInMeters = radiusInMeters
        requestType = .userCatch
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        return .post
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .userCheckIn:
            return "/v1/User/CheckIn"
        case .userCatch:
            return "/v1/User/UserCatch"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        
        switch requestType {
        case .userCatch:
            params[Constants.People.caughtUserId] = caughtUserId as AnyObject?
            params[Constants.People.radiusInMeters] = radiusInMeters as AnyObject?
        case .userCheckIn:
            params[Constants.People.longitude] = longitude as AnyObject?
            params[Constants.People.latitude] = latitude as AnyObject?
        }
        
        return params
    }
    
}