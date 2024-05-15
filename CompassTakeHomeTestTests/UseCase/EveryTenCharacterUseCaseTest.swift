//
//  EveryTenCharacterUseCaseTest.swift
//  CompassTakeHomeTestTests
//
//  Created by Esteban Sánchez on 15/05/2024.
//

import XCTest
import Combine
@testable import CompassTakeHomeTest

class EveryTenCharacterUseCaseTest: XCTestCase {
    
    var useCase: EveryTenCharacterUseCase!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        useCase = EveryTenCharacterUseCase(repository: AboutRepositoryMock())
        cancellables = []
    }
    
    override func tearDown() {
        useCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetEveryTenCharacter() {
        let expectation = XCTestExpectation(description: "Fetch every 10th character")
        
        useCase.getEveryTenCharacter()
            .sink(receiveCompletion: { _ in }, receiveValue: { characters in
                XCTAssertEqual(characters.count, 6)
                XCTAssertEqual(characters[0].character, " ")
                XCTAssertEqual(characters[1].character, " ")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}

// MARK: - Mocks

class AboutRepositoryMock: AboutRepositoryProtocol {
    func getAboutInformation() -> AnyPublisher<String, Error> {
        let response = "a   b   c   a   b   c   a   b   c   a   b   c   a   b   c   a   b   c"
        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
