//  ListView.swift
//  MoodLogFirebase
//

import SwiftUI
import FirebaseFirestore


struct ListView: View {
    @State var moodLogs: [MoodLog] = []

    var body: some View {
        List(moodLogs) { log in
            VStack(alignment: .leading) {
                Text(log.feeling)
                Text("\(log.selectedDate.formatted(date: .abbreviated, time: .omitted))")
                Text("Rating: \(log.moodRating)")
            }
        }
        .onAppear {
            fetchMoodLogs()
        }
    }

    func fetchMoodLogs() {
        let db = Firestore.firestore()
        db.collection("moodLogs")
            .order(by: "selectedDate", descending: true)
            .getDocuments { snapshot, error in
                if let snapshot = snapshot {
                    moodLogs = snapshot.documents.compactMap { doc in
                        try? doc.data(as: MoodLog.self)
                    }
                }
            }
    }
}


#Preview {
    ListView()
}
