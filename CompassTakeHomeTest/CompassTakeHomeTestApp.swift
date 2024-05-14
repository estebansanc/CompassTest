//
//  CompassTakeHomeTestApp.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 13/05/2024.
//

import SwiftUI

@main
struct CompassTakeHomeTestApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(MainViewModel())
        }
    }
}
