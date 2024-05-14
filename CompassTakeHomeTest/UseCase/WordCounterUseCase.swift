//
//  WordCounterUseCase.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 14/05/2024.
//

import Foundation

protocol WordCounterUseCaseProtocol {
    func getWordCounts() async -> [String: Int]
}

class WordCounterUseCase: WordCounterUseCaseProtocol {
    
    private var repository: AboutRepositoryProtocol
    
    init(repository: AboutRepositoryProtocol = AboutRepository()) {
        self.repository = repository
    }
    
    func getWordCounts() async -> [String: Int] {
        let response = await repository.getAboutInformation()
        
        let words: [String] = response
            .components(separatedBy: CharacterSet.whitespacesAndNewlines)
            .map { $0.lowercased() }
        
        var wordCounts: [String: Int] = [:]
        
        for word in words {
            if !word.isEmpty {
                wordCounts[word, default: 0] += 1
            }
        }
        
        return wordCounts
    }
}
