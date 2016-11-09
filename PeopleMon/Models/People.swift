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
import MapKit

// Just a test object to excercise the network stack
class People : NetworkModel {
    
    var userId : String?
    var userName : String?
    var avatarBase64 : String?
    var  longitude : Double?
    var  latitude : Double?
    var created : String?
    var  radiusInMeters : Double?
   
    // Request Type
    enum RequestType {
        case userCheckIn
        case userNearby
        case userCatch
        case userCaught
    }
    var requestType = RequestType.userCheckIn
    
    // empty constructor
    required init() {}
    
    // create an object from JSON
    required init(json: JSON) throws {
        userId = try? json.getString(at: Constants.People.userId)
        userName = try? json.getString(at: Constants.People.userName)
        avatarBase64 = try? json.getString(at: Constants.People.avatarBase64)
        longitude = try? json.getDouble(at: Constants.People.longitude)
        latitude = try? json.getDouble(at: Constants.People.latitude)
        created = try? json.getString(at: Constants.People.created)
    }
    
    init(radiusInMeters: Double) {
        self.radiusInMeters = radiusInMeters
        requestType = .userNearby
    }
    
    init (coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        requestType = .userCheckIn
    }
    
    init(userId: String, radiusInMeters: Double) {
        self.userId = userId
        self.radiusInMeters = radiusInMeters
        requestType = .userCatch
    }
    
    // Always return HTTP.GET
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .userNearby, .userCaught:
            return .get
        default:
            return .post
        }
    }
    
    // A sample path to a single post
    func path() -> String {
        switch requestType {
        case .userCheckIn:
            return "/v1/User/CheckIn"
        case .userNearby:
            return "/v1/User/Nearby"
        case .userCatch:
            return "/v1/User/UserCatch"
        case .userCaught:
            return "/v1/User/Caught"
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        
        switch requestType {
        case .userNearby:
            params[Constants.People.radiusInMeters] = radiusInMeters as AnyObject?
        case .userCatch:
            params[Constants.People.caughtUserId] = userId as AnyObject?
            params[Constants.People.radiusInMeters] = radiusInMeters as AnyObject?
        case .userCheckIn:
            params[Constants.People.latitude] = latitude as AnyObject?
            params[Constants.People.longitude] = longitude as AnyObject?
        case .userCaught:
            break
        }
        
        return params
    }
    
}
