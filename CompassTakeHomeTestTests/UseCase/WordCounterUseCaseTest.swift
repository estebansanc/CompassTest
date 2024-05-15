//
//  WordCounterUseCaseTest.swift
//  CompassTakeHomeTestTests
//
//  Created by Esteban Sánchez on 15/05/2024.
//

import XCTest
import Combine
@testable import CompassTakeHomeTest

class WordCounterUseCaseTest: XCTestCase {
    
    var useCase: WordCounterUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        useCase = WordCounterUseCase(repository: AboutRepositoryMock())
        cancellables = []
    }
    
    override func tearDown() {
        useCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetWordCounts() {
        let expectation = XCTestExpectation(description: "Fetch word counts")
        
        useCase.getWordCounts()
            .sink(receiveCompletion: { _ in }, receiveValue: { wordCounts in
                XCTAssertEqual(wordCounts["a"], 6)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}

