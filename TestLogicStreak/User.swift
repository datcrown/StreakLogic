//
//  User.swift
//  DemoKP
//
//  Created by Quoc Dat on 2/5/18.
//  Copyright © 2018 BigZero. All rights reserved.
//

import Foundation
class User {
    var name: String = ""
    var dateOfBirth: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var address: String = ""
    var gender: String = ""
    var streak: Int = 0
    var password: String = ""
    var todayScore: Int = 0
    var lastScore: Int = 0
    init(name: String, dateOfBirth: String,telephoneNumber: String, email: String, address: String, gender: String, password: String, streak: Int, todayScore: Int) {
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = telephoneNumber
        self.email = email
        self.address = address
        self.gender = gender
        self.password = password
        self.streak = streak
        self.todayScore = todayScore
    }
    func convertToDictionary() -> [String: Any] {
        let values: [String : Any] = ["name": name,
                                      "email": email,
                                      "password": password ,
                                      "phone": phoneNumber,
                                      "address": address,
                                      "birthDay" : dateOfBirth,
                                      "gender": gender,
                                      "streak": streak ]
        return values
    }
    func convertScoreToDictionary() -> [String: Int] {
        let score: [String: Int] = ["todayScore" : todayScore,
                                    "lastDayScore": lastScore]
        return score
    }
}
