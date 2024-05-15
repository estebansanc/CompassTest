//
//  HelpCenterView.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 15/05/2024.
//

import SwiftUI

let takeHomeTest: String = """
Write a simple application that defines and runs 2 requests simultaneously, each request is defined below:

1- Every10thCharacterRequest:
    a. Grab https://www.compass.com/about/ content from the web
    b. Find every 10th character (i.e. 10th, 20th, 30th, etc.) and display the array on the screen

2- WordCounterRequest:
    a. Grab https://www.compass.com/about/ content from the web
    b. Split the text into words using whitespace characters (i.e. space, tab, line break, etc.), count the occurrence of every unique word (case insensitive) and display the count for each word on the screen

Consider the content plain-text, regardless of what is returned by the response. Treat anything separated
by whitespace characters as a single word. Example:
"<p> Compass Hello World </p>" should produce +1 for each of these: "<p>", "Compass",
"Hello", "World", and "</p>".

The application should:
1. Show a single Button to run the two requests simultaneously
2. Show the results  single TextView of each request above as soon as the processing of the corresponding request finishes, displayed in views representing lists
3. Data should be cached and made available offline after the first fetch
4. The code should be unit tested
"""

struct HelpCenterView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Label("Developer information", systemImage: "person.fill")
                        .font(.headline)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading) {
                                Label("Name", systemImage: "person.fill")
                                    .font(.caption)
                                
                                Text("Esteban Nicolás Sánchez")
                            }
                            
                            VStack(alignment: .leading) {
                                Label("Phone number", systemImage: "phone.circle.fill")
                                    .font(.caption)
                                
                                Text("+54 381 5683728")
                            }
                            
                            VStack(alignment: .leading) {
                                Label("GitHub", systemImage: "person.crop.circle.fill")
                                    .font(.caption)
                                
                                Text("@estebansanc")
                            }
                            
                            VStack(alignment: .leading) {
                                Label("Email", systemImage: "person.crop.circle.fill")
                                    .font(.caption)
                                
                                Text("esteban.nicolas.sanc@gmail.com")
                                    .font(.caption)
                            }
                            
                            VStack(alignment: .leading) {
                                Label("LinkedIn", systemImage: "person.crop.circle.fill")
                                    .font(.caption)
                                
                                Text("https://www.linkedin.com/in/esteban-nicolas-sanchez-79b428172/")
                                    .font(.caption)
                            }
                        }
                        
                        Spacer()
                        
                        Image("ProfileImage")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(color: .brown, radius: 20)
                    }
                    .font(.callout)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    
                    Divider()
                        .padding()
                    
                    Label("Take home test", systemImage: "book.fill")
                        .font(.headline)
                    
                    Text(takeHomeTest)
                        .font(.callout)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
                .padding()
            }
            .navigationTitle("Help Center")
        }
    }
}

#Preview {
    HelpCenterView()
}
