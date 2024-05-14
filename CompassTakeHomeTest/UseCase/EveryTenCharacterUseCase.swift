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
        return response.components(separatedBy: ", ")
    }
}
