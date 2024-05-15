//
//  MainViewModel.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 13/05/2024.
//

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var every10thCharacter: [CharacterWithIndex] = []
    @Published var wordCounts: [String: Int] = [:]
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    // Properties
    private var cancellables = Set<AnyCancellable>()
    private var tenCharacterUseCase: EveryTenCharacterUseCaseProtocol
    private var wordCounterUseCase: WordCounterUseCaseProtocol
    
    init(tenCharacterUseCase: EveryTenCharacterUseCaseProtocol = EveryTenCharacterUseCase(),
         wordCounterUseCase: WordCounterUseCaseProtocol = WordCounterUseCase()
    ) {
        self.tenCharacterUseCase = tenCharacterUseCase
        self.wordCounterUseCase = wordCounterUseCase
    }
    
    // MARK: - Public
    
    func runAllRequest() {
        isLoading = true
        
        tenCharacterUseCase.getEveryTenCharacter()
            .combineLatest(wordCounterUseCase.getWordCounts())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] characters, counts in
                self?.every10thCharacter = characters
                self?.wordCounts = counts
            }
            .store(in: &cancellables)
    }
}
