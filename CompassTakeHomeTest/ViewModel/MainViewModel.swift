//
//  MainViewModel.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 13/05/2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var result1: String = "Resultado..."
    @Published var result2: String = "Resultado..."
    @Published var errorPrompt: String = ""
    
    // Properties
    private var tenCharacterUseCase: EveryTenCharacterUseCaseProtocol
    private var wordCounterUseCase: WordCounterUseCaseProtocol
    
    init(tenCharacterUseCase: EveryTenCharacterUseCaseProtocol = EveryTenCharacterUseCase(),
         wordCounterUseCase: WordCounterUseCaseProtocol = WordCounterUseCase()
    ) {
        self.tenCharacterUseCase = tenCharacterUseCase
        self.wordCounterUseCase = wordCounterUseCase
    }
    
    // MARK: - Public
    
    public func runAllRequests() async {
        let response = await tenCharacterUseCase.getEveryTenCharacter()
        withAnimation {
            result1 = response.reduce("", { "\($0) - \($1)"})
        }
    }
}
