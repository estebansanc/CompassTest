//
//  ContentView.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 13/05/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    
    @State private var showingActionSheet = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("First request result:") {
                    Text("\(viewModel.result1)")
                }
                
                Section("Second request result:") {
                    Text("\(viewModel.result2)")
                }
                
                Button("Run all requests", systemImage: "bolt.fill") {
                    Task {
                        await viewModel.runAllRequests()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .onChange(of: viewModel.errorPrompt) { oldValue, newValue in
                showingActionSheet = newValue != oldValue
            }
            .alert("An error has ocurred...", isPresented: $showingActionSheet) {
                Button("Continue") { showingActionSheet = false }
            } message: {
                Text(viewModel.errorPrompt)
            }
            .navigationTitle("Compass Test")
        }
    }
}

#Preview {
    MainView()
}
