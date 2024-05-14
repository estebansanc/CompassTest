//
//  WordCounterUseCase.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 14/05/2024.
//

import Foundation

protocol WordCounterUseCaseProtocol {
    func getWordCounter() async -> [String: Int]
}

class WordCounterUseCase: WordCounterUseCaseProtocol {
    
    private var repository: AboutRepositoryProtocol
    
    init(repository: AboutRepositoryProtocol = AboutRepository()) {
        self.repository = repository
    }
    
    func getWordCounter() async -> [String: Int] {
        let response = await repository.getAboutInformation()
        let words = response.components(separatedBy: ", ")
        var wordCounter: [String: Int] = [:]
        
        for word in words {
            wordCounter[word] = 1
        }
        
        return wordCounter
    }
}
