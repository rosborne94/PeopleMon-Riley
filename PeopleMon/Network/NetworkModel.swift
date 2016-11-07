//
//  NetworkModel.swift
//  PeopleMon
//
//  Created by Riley Osborne on 10/31/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

//Describes what you need to make network request and read it
protocol NetworkModel: JSONDecodable {
    //create the object by reading json
    init(json: JSON) throws
    init()
    
    // what is the HTTP method (GEt/post/put/etc)
    func method () -> Alamofire.HTTPMethod
    //rest URL to the resource i.e. http://server.com/posts/1
    func path() -> String
    //convert the object to a dictionary for later conversion to JSON
    func toDictionary() -> [String: AnyObject]?
}

