//
//  MoodLog.swift
//  MoodleLogv12c
//
//  Created by Chris Maker on 19/7/2026.
//

import SwiftUI
import FirebaseFirestore

struct MoodLog: Identifiable, Codable {
    @DocumentID var id: String?
    var userID: String
    var feeling: String
    var selectedDate: Date
    var moodRating: Int
}


