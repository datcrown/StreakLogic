//
//  DataService.swift
//  LearningEnglish
//
//  Created by Quoc Dat on 3/5/18.
//  Copyright © 2018 BigZero. All rights reserved.
//

import Foundation
import UIKit
class DataService {
    static let shared: DataService = DataService()
    var streak: Int?
    var user = User(name: "dat", dateOfBirth: "02/12/1998", telephoneNumber: "0961021643", email: "datcrown0212@gmail.com", address: "BIG0", gender: "Male", password: "123456", streak: 0, todayScore: 0)
    
    //MARK: - Streak
    func isFinishDailyQuest() -> Bool {
         let todayScore = user.todayScore 
        if todayScore == 100 {
            return true
        } else { return false }
    }
    func plusStreak() {
        if isFinishDailyQuest() {
            user.streak +=  1
        }
    }
    func removeStreak() {
        user.streak = 0
    }
   
    

}
