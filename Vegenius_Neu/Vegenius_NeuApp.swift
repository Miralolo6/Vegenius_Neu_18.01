//
//  Vegenius_NeuApp.swift
//  Vegenius_Neu
//
//  Created by TA604 on 18.01.26.
//

import SwiftUI

@main
struct Vegenius_NeuApp: App {
    @StateObject private var store = RecipeStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
