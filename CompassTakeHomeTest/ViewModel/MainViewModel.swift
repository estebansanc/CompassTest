//
//  MainViewModel.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 13/05/2024.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var everyThenCharacter: [Character]? = nil
    @Published var wordsCount: [String: Int]? = nil
    
    // Properties
    private var cancellables: [AnyCancellable?] = []
    
    private var tenCharacterUseCase: EveryTenCharacterUseCaseProtocol
    private var wordCounterUseCase: WordCounterUseCaseProtocol
    
    init(tenCharacterUseCase: EveryTenCharacterUseCaseProtocol = EveryTenCharacterUseCase(),
         wordCounterUseCase: WordCounterUseCaseProtocol = WordCounterUseCase()
    ) {
        self.tenCharacterUseCase = tenCharacterUseCase
        self.wordCounterUseCase = wordCounterUseCase
    }
    
    // MARK: - Public
    
    func fetchEvery10thCharacter() {
        guard let url = URL(string: "https://www.compass.com/about/") else { return }
        
        let cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map { String(data: $0, encoding: .utf8) ?? "" }
            .map { self.extractEvery10thCharacter(from: $0) }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.everyThenCharacter, on: self)
        
        cancellables.append(cancellable)
    }
    
    func fetchWordCounts() {
        guard let url = URL(string: "https://www.compass.com/about/") else { return }
        
        let cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map { String(data: $0, encoding: .utf8) ?? "" }
            .map { self.countWords(in: $0) }
            .replaceError(with: [:])
            .receive(on: DispatchQueue.main)
            .assign(to: \.wordsCount, on: self)
        
        cancellables.append(cancellable)
    }
    
    // MARK: - Private
    
    private func extractEvery10thCharacter(from content: String) -> [Character] {
        var result: [Character] = []
        let characters = Array(content)
        
        for index in stride(from: 9, to: characters.count, by: 10) {
            result.append(characters[index])
        }
        
        return result
    }
    
    private func countWords(in content: String) -> [String: Int] {
        var wordCounts: [String: Int] = [:]
        let words = content.components(separatedBy: CharacterSet.whitespacesAndNewlines).map { $0.lowercased() }
        
        for word in words {
            if !word.isEmpty {
                wordCounts[word, default: 0] += 1
            }
        }
        
        return wordCounts
    }
}
