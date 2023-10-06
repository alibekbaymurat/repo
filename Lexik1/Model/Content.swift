//
//  Content.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 21.08.2023.
//

import Firebase

struct PostContent: Identifiable {
    let id: String
    let userId: String
    let caption: String
    let likes: Int
    let timestamp: Timestamp
        
    init(dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? String ?? ""
        self.id = dictionary["uid"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }
    
    var detailedTimestampString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a · MM/dd/yyyy"
        return formatter.string(from: timestamp.dateValue())
    }
}
