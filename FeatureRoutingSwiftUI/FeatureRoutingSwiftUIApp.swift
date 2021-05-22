//
//  FeatureRoutingSwiftUIApp.swift
//  FeatureRoutingSwiftUI
//
//  Created by Sergey Nikolsky on 22/5/21.
//

import SwiftUI

// 1. Root list -> Details (Show Regions) -> Regions
// 2. Root list -> Regions (Show Details) -> Details

@main
struct FeatureRoutingSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
