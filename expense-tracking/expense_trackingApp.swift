//
//  expense_trackingApp.swift
//  expense-tracking
//
//  Created by Kyle lee on 5/29/24.
//

import SwiftUI
import Firebase

@main
struct expense_trackingApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
