//
//  EveryTenCharacterUseCase.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 14/05/2024.
//

import Foundation

protocol EveryTenCharacterUseCaseProtocol {
    func getEveryTenCharacter() async -> [String]
}

class EveryTenCharacterUseCase: EveryTenCharacterUseCaseProtocol {
    
    private var repository: AboutRepositoryProtocol
    
    init(repository: AboutRepositoryProtocol = AboutRepository()) {
        self.repository = repository
    }
    
    func getEveryTenCharacter() async -> [String] {
        let response = await repository.getAboutInformation()
        
        var result: [String] = []
        let characters = Array(response)
        
        for index in stride(from: 10, to: characters.count, by: 10) {
            result.append("\(characters[index])")
        }
        
        return result
    }
}
