//
//  User.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 20.08.2023.
//

import Firebase

struct User: Identifiable {
    let id: String
    let username: String
    let fullname: String
    let email: String
    
    var rate: UserRate
    var followers: Int
    var following: Int
    var bio: String?
    
    var isFollowed = false
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.followers = 0
        self.following = 0
        self.bio = dictionary["bio"] as? String ?? ""
        self.rate = UserRate(uprate: 0, downrate: 0)
    }
}

struct UserRate {
    var uprate: Int
    var downrate: Int
}
