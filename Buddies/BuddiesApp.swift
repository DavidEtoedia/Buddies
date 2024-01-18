//
//  BuddiesApp.swift
//  Buddies
//
//  Created by Inyene Etoedia on 02/01/2024.
//

import SwiftUI

@main
struct BuddiesApp: App {
    @State private var controller = Controller()
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(controller)
        }
    }
}

