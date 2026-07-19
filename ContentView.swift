import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView{
            VStack() {
                NavigationLink("Add New Task", destination: AddNewView())
                NavigationLink("View Tasks", destination: ListView())
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(appState.userEmail).font(.footnote)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Out") {
                        logOut()
                    }
                }
            }
        }
        
    }
    func logOut() {
        do {
            try Auth.auth().signOut()
            appState.isLoggedIn = false
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}


#Preview {
    ContentView()
}
