//
//  APIV2.swift
//  Level
//
//  Created by Pratik on 21/12/21.
//

import Foundation
import UIKit

struct BaseUrls {
    static var current: String {
        return v2
    }
    
    static var v2 = "https://nimayatecs.in/rotary_alpha_3141/public/api/"//"https://level-meditationv3-xbvmavvhka-uc.a.run.app/v1/"
}

enum APIV2: API {
    case login(PhoneNo: String)
    
    case otp(PhoneNo: String, otp: String)
    
    case dashboardVideos
    
    case dashboardPhotos
    
    case dashboardResources
    
    case dashboardPublications
    
    case dashboardMembers
    
    case searchMember(searchText: String, designation: String, club_name: String)
    
    case dashboardBirthday
    
    case alphaDirectory
    
    case dashboardCommunication
    
    case dashboardEvent
    
    case eventPhotos(id: Int)
    
    case eventVideos(id: Int)
    
    case eventSchedules(id: Int)
    
    case eventResources(id: Int)
    
    case dashboardSlider
    
    case singleEvent(id: Int)
    
    case notifications
}



extension APIV2 {
    var baseURL: URL {
        URL(string: BaseUrls.current)!

    }
    
    var path: String {
        switch self {
            
        case .login:
            return "login"
            
        case .otp:
            return "otp"
            
        case .dashboardVideos:
            return "v2/get/public/videos"
            
        case .dashboardPhotos:
            return "v3/get/public/photos"
            
        case .dashboardResources:
            return "get/public/resources"
            
        case .dashboardPublications:
            return "get/public/publications"
            
        case .dashboardMembers:
            return "get/members"
            
        case .searchMember:
            return "search/member"
            
        case .dashboardBirthday:
            return "v2/bday/annivarsary"
            
        case .alphaDirectory:
            return "get/alpha_directory"
            
        case .dashboardCommunication:
            return "get/news_letters"
            
        case .dashboardEvent:
            return "v2/get/events"
            
        case .eventPhotos(id: let id):
            return "v3/get/event/\(id)/photos"
            
        case .eventVideos(id: let id):
            return "get/event/\(id)/videos"
            
        case .eventSchedules(id: let id):
            return "get/event/\(id)/schedule"
            
        case .eventResources(id: let id):
            return "get/event/\(id)/resources"
            
        case .dashboardSlider:
            return "get/dashboard/slider"
            
        case .singleEvent(id: let id):
            return "get/event/\(id)"
            
        case .notifications:
            return "notifications"
        }
    }

    
    var method: String {
        switch self {
            
        case .login:
            return "POST"
            
        case .otp:
            return "POST"

        case .dashboardVideos:
            return "GET"
            
        case .dashboardPhotos:
            return "GET"

        case .dashboardResources:
            return "GET"

        case .dashboardPublications:
            return "GET"

        case .dashboardMembers:
            return "GET"
            
        case .searchMember:
            return "POST"
            
        case .dashboardBirthday:
            return "GET"
            
        case .alphaDirectory:
            return "GET"

        case .dashboardCommunication:
            return "GET"
            
        case .dashboardEvent:
            return "GET"

        case .eventPhotos:
            return "GET"

        case .eventVideos:
            return "GET"

        case .eventSchedules:
            return "GET"

        case .eventResources:
            return "GET"

        case .dashboardSlider:
            return "GET"

        case .singleEvent:
            return "GET"

        case .notifications:
            return "GET"

        }
}
}

extension APIV2 {
    var params: [String : Any] {
        var params: [String : Any] = [:]
        switch self {
            
        case .login(PhoneNo: let PhoneNo):
            params = ["PhoneNo": PhoneNo]
            
        case .otp(PhoneNo: let PhoneNo, otp: let otp):
            params = ["PhoneNo": PhoneNo, "otp": otp]

        case .dashboardVideos:
            break
            
        case .dashboardPhotos:
            break
            
        case .dashboardResources:
            break
            
        case .dashboardPublications:
            break
            
        case .dashboardMembers:
            break
            
        case .searchMember(searchText: let searchText, designation: let designation, club_name: let club_name):
            params = ["searchText": searchText, "designation": designation, "club_name": club_name]

        case .dashboardBirthday:
            break
            
        case .alphaDirectory:
            break
            
        case .dashboardCommunication:
            break
            
        case .dashboardEvent:
            break
        case .eventPhotos:
            break
            
        case .eventVideos:
            break
            
        case .eventSchedules:
            break
            
        case .eventResources:
            break
            
        case .dashboardSlider:
            break
            
        case .singleEvent:
            break
            
        case .notifications:
            break
        }
        return params

    }
}

extension APIV2 {
    var headers: [String : String]? {
        var headers: [String : String] = [:]
        let token = UserDefaults.standard.login_token ?? ""
        if token != "" {
            headers = ["Content-Type" : "application/json", "Authorization": "Bearer \(token)"]
        } else {
            headers = ["Content-Type" : "application/json"]
        }
        
        return headers    }
    
}

