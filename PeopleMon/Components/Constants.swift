//
//  Constants.swift
//  PeopleMon
//
//  Created by Riley Osborne on 10/31/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    // Step 16: Add monthDayYear
    static let monthDayYear = "MM/dd/yyyy"
    
    // Step 7: Add keychain strings
    public static let keychainIdentifier = "PeopleMonKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    static let apiKey = "iOS301november2016"
    static let apikey = "ApiKey"
    
    // Step 19: Add Notification constant
    static let newExpensesFound = "NewExpensesFound"
    
    // Step 4: JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
  /*  {
    "Id": "string",
    "Email": "string",
    "HasRegistered": true,
    "LoginProvider": "string",
    "FullName": "string",
    "AvatarBase64": "string",
    "LastCheckInLongitude": 0,
    "LastCheckInLatitude": 0,
    "LastCheckInDateTime": "2016-11-07T01:11:03.917Z"
    }
     {
 "OldPassword": "string",
 "NewPassword": "string",
 "ConfirmPassword": "string"
 }*/
    // Step 9: BudgetUser Constants
    struct UserInfo {
        static let id = "Id"
        static let email = "Email"
        static let userName = "username"
        static let hasRegistered = "HasRegistered"
        static let loginProvider = "LoginProvider"
        static let avatarBase64 = "AvatarBase64"
        static let lastCheckInLongitude = "LastCheckInLongitude"
        static let lastCheckInLatitude = "LastCheckInLatitude"
        static let lastCheckInDateTime = "LastCheckInDateTime"
        static let apiKey = "ApiKey"
        static let oldPassword = "OldPassword"
        static let newPassword = "NewPassword"
        static let confirmPassword = "ConfirmPassword"
        static let fullName = "FullName"
        static let password = "password"
        static let token = "access_token"
        static let expiration = ".expires"
        static let grantType = "grant_type"
    }
    
/*
 {
 "UserId": "string",
 "UserName": "string",
 "AvatarBase64": "string",
 "Longitude": 0,
 "Latitude": 0,
 "Created": "2016-11-07T01:11:03.965Z"
 }
{
     "CaughtUserId": "string",
     "RadiusInMeters": 0
     }
     {
     "Count": 0,
     "RecipientName": "string",
     "SenderName": "string",
     "Messages": [
     {
     "MessageId": 0,
     "Message": "string",
     "Created": "2016-11-07T01:11:03.994Z",
     "RecipientUserId": "string",
     "SenderUserId": "string"
     }
     ]
     }
     {
     "RecipientId": "string",
     "Message": "string"
     }
 */
 
    // Step 10: Category Constants
    struct People {
        static let userId = "UserId"
        static let userName = "UserName"
        static let avatarBase64 = "AvatarBase64"
        static let longitude = "Longitude"
        static let latitude = "Latitude"
        static let user = "user"
        static let created = "Created"
        
        static let caughtUserId = "CaughtUserId"
        static let radiusInMeters = "RadiusInMeters"
        
        static let count = "Count"
        static let recipientName = "RecipientName"
        static let senderName = "SenderName"
        static let messages = "Messages"
        static let conversationsId = "ConversationsId"
        static let lastMessage = "LastMessage"
        static let senderAvatarBase64 = "SenderAvatarBase64"
        static let recipientAvatarBase64 = "RecipientAvatarBase64"
        static let messageCount = "MessageCount"
        
        static let messageId = "MessageId"
        static let message = "Message"
        static let recipientUserId = "RecipientUserId"
        static let senderUserId = "SenderUserId"
        
        static let recipientId = "RecipientId"
        
        static let pageSize = "pageSize"
        static let  pageNumber = "pageNumber"
        static let id = "id"
        static let authorization = "Authorization"
    }
    
}

// MARK: - Colors
// Step 14: UIColor extension and
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}

struct ColorPalette {
    static let PositiveColor = UIColor.rgba(red: 15, green: 181, blue: 46)
    static let NegativeColor = UIColor.rgba(red: 219, green: 31, blue: 31)
    static let BlueColor = UIColor.rgba(red: 12, green: 35, blue: 64)
    static let GoldColor = UIColor.rgba(red: 201, green: 151, blue: 0)
    static let calendarCellColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.1)
    static let calendarTodayColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.3)
    static let calendarBorderColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.8)
}
