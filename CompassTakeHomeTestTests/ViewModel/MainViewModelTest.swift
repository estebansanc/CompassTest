//
//  MainViewModelTest.swift
//  CompassTakeHomeTestTests
//
//  Created by Esteban Sánchez on 15/05/2024.
//

import XCTest
import Combine
@testable import CompassTakeHomeTest

class MainViewModelTest: XCTestCase {
    
    var viewModel: MainViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel(tenCharacterUseCase: EveryTenCharacterUseCaseMock(),
                                  wordCounterUseCase: WordCounterUseCaseMock())
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testRunAllRequestSuccess() {
        let expectation = XCTestExpectation(description: "Fetch data successfully")
        
        viewModel.$every10thCharacter
            .dropFirst()
            .sink { characters in
                XCTAssertEqual(characters.count, 3)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.$wordCounts
            .dropFirst()
            .sink { wordCounts in
                XCTAssertEqual(wordCounts["test"], 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.runAllRequest()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRunAllRequestFailure() {
        let failingViewModel = MainViewModel(tenCharacterUseCase: EveryTenCharacterUseCaseFailureMock(),
                                             wordCounterUseCase: WordCounterUseCaseMock())
        
        let expectation = XCTestExpectation(description: "Fetch data with failure")
        
        failingViewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        failingViewModel.runAllRequest()
        
        wait(for: [expectation], timeout: 2.0)
    }
}

// MARK: - Mocks

class EveryTenCharacterUseCaseMock: EveryTenCharacterUseCaseProtocol {
    func getEveryTenCharacter() -> AnyPublisher<[CharacterWithIndex], Error> {
        let characters = [
            CharacterWithIndex(id: 1, character: "a", indexText: "10th"),
            CharacterWithIndex(id: 2, character: "b", indexText: "20th"),
            CharacterWithIndex(id: 3, character: "c", indexText: "30th")
        ]
        return Just(characters)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class WordCounterUseCaseMock: WordCounterUseCaseProtocol {
    func getWordCounts() -> AnyPublisher<[String: Int], Error> {
        let wordCounts = ["test": 2]
        return Just(wordCounts)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class EveryTenCharacterUseCaseFailureMock: EveryTenCharacterUseCaseProtocol {
    func getEveryTenCharacter() -> AnyPublisher<[CharacterWithIndex], Error> {
        return Fail(error: URLError(.badURL))
            .eraseToAnyPublisher()
    }
}
