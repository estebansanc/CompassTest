//
//  ContentView.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 13/05/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Every 10th characters:")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if !viewModel.every10thCharacter.isEmpty {
                            charactersView
                        } else {
                            emptyContentView
                        }
                    }
                    
                    Divider()
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Words count:")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if !viewModel.wordCounts.isEmpty {
                            wordsView
                        } else {
                            emptyContentView
                        }
                    }
                }
                .safeAreaPadding(.top)
                .safeAreaPadding(.bottom, 80)
                .scrollIndicators(.hidden)
                
                Button {
                    viewModel.runAllRequest()
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Label("Run all requests", systemImage: "bolt.fill")
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(.ultraThinMaterial)
                .disabled(viewModel.isLoading)
            }
            .toolbar {
                NavigationLink {
                    HelpCenterView()
                } label: {
                    Button("Help center", systemImage: "questionmark.circle") { }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("An error has occurred..."), 
                      message: Text(viewModel.errorMessage ?? "Unknown error"),
                      dismissButton: .default(Text("Continue")))
            }
            .onReceive(viewModel.$errorMessage) { errorMessage in
                showAlert = errorMessage != nil
            }
            .navigationTitle("Compass Test")
        }
    }
    
    var emptyContentView: some View {
        ContentUnavailableView("Please run requests to see results...", systemImage: "bolt.fill")
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .padding()
    }
    
    var charactersView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))], spacing: 16) {
                ForEach(viewModel.every10thCharacter, id: \.id) { item in
                    VStack {
                        Text("\(item.character)")
                        
                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                        
                        Text("\(item.indexText)")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(Capsule())
                }
            }
        }
        .frame(height: 200)
        .safeAreaPadding()
    }
    
    var wordsView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 90))], spacing: 16) {
                ForEach(viewModel.wordCounts.sorted(by: { $0.key < $1.key }), id: \.key) { word, count in
                    NavigationLink {
                        VStack {
                            Text(word)
                                .lineLimit(nil)
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                            
                            Text("Count: \(count)")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .navigationTitle("Word details")
                        
                    } label: {
                        VStack {
                            Text(word)
                                .frame(maxWidth: 200)
                                .lineLimit(1)
                            
                            Rectangle()
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                                .background(.regularMaterial)
                            
                            HStack(spacing: 16) {
                                Text("Count: \(count)")
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .font(.caption)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .frame(height: 300)
        .safeAreaPadding()
    }
}

#Preview {
    MainView()
        .environmentObject(MainViewModel())
}
