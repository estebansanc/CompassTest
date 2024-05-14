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
            VStack {
                Form {
                    Section("Every 10th characters:") {
                        if let characters = viewModel.everyThenCharacter {
                            ForEach(characters, id: \.self) {
                                Text("\($0)")
                            }
                        } else {
                            ContentUnavailableView("Please run requests to see results...", systemImage: "bolt.fill")
                        }
                    }
                    
                    Section("Words count:") {
                        if let wordsCount = viewModel.wordsCount?.sorted(by: { $0.key < $1.key }) {
                            ForEach(wordsCount, id: \.key) { word, count in
                                HStack {
                                    Text(word)
                                    Spacer()
                                    Text("\(count)")
                                }
                            }
                        } else {
                            ContentUnavailableView("Please run requests to see results...", systemImage: "bolt.fill")
                        }
                    }
                }
                
                Button("Run all requests", systemImage: "bolt.fill") {
                    viewModel.fetchEvery10thCharacter()
                    viewModel.fetchWordCounts()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
            }
//            .onChange(of: viewModel.errorPrompt) { oldValue, newValue in
//                showingActionSheet = newValue != oldValue
//            }
//            .alert("An error has ocurred...", isPresented: $showingActionSheet) {
//                Button("Continue") { showingActionSheet = false }
//            } message: {
//                Text(viewModel.errorPrompt)
//            }
            .navigationTitle("Compass Test")
        }
    }
}

#Preview {
    MainView()
        .environmentObject(MainViewModel())
}
