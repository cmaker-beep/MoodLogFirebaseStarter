//
//  AppUser.swift
//  MoodleLogv12c
//
//  Created by Chris Maker on 19/7/2026.
//

import SwiftUI


import FirebaseFirestore

struct AppUser: Codable {
    @DocumentID var id: String?
    var email: String
}

