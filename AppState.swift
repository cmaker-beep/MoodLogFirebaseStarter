//
//  AppState.swift
//  MoodleLogv12c
//
//  Created by Chris Maker on 19/7/2026.
//
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userEmail: String = ""
    @Published var userDocumentID: String = ""
}


