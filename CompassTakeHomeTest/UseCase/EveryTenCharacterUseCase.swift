//
//  EveryTenCharacterUseCase.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 14/05/2024.
//

import Foundation
import Combine

struct CharacterWithIndex: Identifiable {
    let id: Int
    let character: Character
    let indexText: String
}

protocol EveryTenCharacterUseCaseProtocol {
    func getEveryTenCharacter() -> AnyPublisher<[CharacterWithIndex], Error>
}

class EveryTenCharacterUseCase: EveryTenCharacterUseCaseProtocol {
    
    private var repository: AboutRepositoryProtocol
    
    init(repository: AboutRepositoryProtocol = AboutRepository()) {
        self.repository = repository
    }
    
    func getEveryTenCharacter() -> AnyPublisher<[CharacterWithIndex], Error> {
        repository.getAboutInformation()
            .map { response in
                var result: [CharacterWithIndex] = []
                let characters = Array(response)
                
                for index in stride(from: 10, to: characters.count, by: 10) {
                    result.append(CharacterWithIndex(id: index,
                                                     character: characters[index],
                                                     indexText: "\(index)th"))
                }
                return result
            }
            .eraseToAnyPublisher()
    }
}
