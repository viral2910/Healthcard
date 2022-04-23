//
//  Environment.swift
//  Level
//
//  Created by Pratik on 13/12/21.
//

import Foundation
import UIKit

class Environment: NSObject {

    static var isNetworkAvalibale = Bool()
    static var showingNoInternetAlert = Bool()
    static var deviceToken = String()
    static var accessToken_Str = String()
    
    struct GlobarlUrls {
        static let blurColor = UIColor.init(hexString: "007AB8")

    }
    
    
    struct ActivityId {
                
        static let ACTIVITY_WORKOUT = "1"
        
        static let ACTIVITY_MEDITATION = "2"
        
        static let ACTIVITY_MUSIC = "3"
        
        static let ACTIVITY_BREATH = "4"
        
        static let ACTIVITY_SLEEP = "5"
        
        static let ACTIVITY_JOURNAL = "6"
        
        static let ACTIVITY_SMILE_DETECTION = "7"
        
        static let ACTIVITY_COLLECT_SUNRISE = "8"
        
        static let ACTIVITY_AFFIRMATION = "9"
        
        static let ACTIVITY_GROUP_MEDITATION = "10"
        
        static let ACTIVITY_DRINK_WATER = "11"
        
        static let ACTIVITY_MOOD_PRIORITY = "12"
        
    }
    
    struct ActivityCoins {
        
        static let WORKOUT_COIN_TO_PLAY = 10
        
        static let MEDITATION_COIN_TO_PLAY = 10
        
        static let MINI_GAME_COIN_TO_PLAY = 5
        
        static let WORKOUT_RUN_COIN_TO_PLAY = 0
        
        static let WORKOUT_RUN_EARN_XP = 10

        static let SLEEP_STORY_COIN_TO_PLAY = 0
        
        static let MUSIC_COIN_TO_PLAY = 0

        static let MOOD_PRIORITY_EARN_XP = 10
        
        static let MINI_GAME_EARN_XP = 10
        
    }
    
    struct Policy {
        static let URL_PRIVACY = "https://www.level.game/privacy-policy"
        static let URL_TERMS = "https://www.level.game/terms-and-conditions"
        static let URL_ABOUT = "https://about.level.game/"
        static let termsForBeta = "https://www.level.game/beta-users-terms-of-use"
    }
}

