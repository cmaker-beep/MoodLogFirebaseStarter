//  AddNewView.swift
//  MoodLogFirebase
//

import SwiftUI
import FirebaseFirestore

struct AddNewView: View {
    @State var feeling: String = ""
    @State var selectedDate: Date = Date()
    @State var moodRating: Int = 1
    
    @EnvironmentObject var appState: AppState
    
    @State var showAlert = false

    let db = Firestore.firestore()

    var body: some View {
        VStack {
            TextField("How are you feeling today?", text: $feeling)
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
            Stepper("Mood Rating: \(moodRating)", value: $moodRating, in: 1...5)
            Button("Save Mood") {
                addNewMood()
            }
        }
        .padding()
        .alert("New record added", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }

    func addNewMood() {
        let moodLog = MoodLog(
            id: nil,
            userID: appState.userDocumentID,
            feeling: feeling,
            selectedDate: selectedDate,
            moodRating: moodRating
        )

        do {
            try db.collection("moodLogs").addDocument(from: moodLog) { error in
                if error == nil {
                    feeling = ""
                    selectedDate = Date()
                    moodRating = 1
                    showAlert = true
                } else {
                    print("Error adding mood log: \(error!.localizedDescription)")
                }
            }
        } catch {
            print("Encoding error: \(error)")
        }
    }
}

#Preview {
    AddNewView()
}
