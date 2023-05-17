//
//  TinyTasksApp.swift
//  TinyTasks
//
//  Created by Victor Mihaita on 16.05.2023.
//

import SwiftUI

@main
struct TinyTasksApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TodosView()
                    .environment(\.managedObjectContext, DataManager.shared.viewContext)
            }
        }
    }
}
