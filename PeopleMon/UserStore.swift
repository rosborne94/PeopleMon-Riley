//
//  UserStore.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/8/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit

protocol  UserStoreDelegate: class {
    func userLoggedIn()
}

class UserStore {
    // singleton
    static let shared = UserStore()
    private init () {}
    
    var selectedImage: UIImage?
    
    var user: User? {
        didSet {
            if let _ = user {
                delegate?.userLoggedIn()
            }
        }
    }
    weak var delegate: UserStoreDelegate?
    
    func login(_ loginUser: User, completion: @escaping (_ success:Bool, _ error: String?) -> Void) {
        
        // Call web serice to login
        WebServices.shared.authUser(loginUser) { (user, error) in
            if let user = user  {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    func register(_ registerUser: User, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        WebServices.shared.authUser(registerUser) { (user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    func logout(_ completion: () -> Void) {
        WebServices.shared.clearUserAuthToken()
        completion()
    }
}
