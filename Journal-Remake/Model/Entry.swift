//
//  Entry.swift
//  Journal-Remake
//
//  Created by Annicha on 3/5/19.
//  Copyright © 2019 Annicha Hanwilai. All rights reserved.
//

import Foundation

class Entry: Codable {
    let timestamp: Date
    var title: String
    var bodyText: String
    
    init(timestamp: Date = Date.init(), title: String, bodyText: String) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.timestamp == rhs.timestamp &&
        lhs.title == rhs.title &&
        lhs.bodyText == rhs.bodyText
    }
    
}
