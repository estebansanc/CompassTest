//
//  AboutRepositoryTest.swift
//  CompassTakeHomeTestTests
//
//  Created by Esteban Sánchez on 15/05/2024.
//

import XCTest
import Combine
@testable import CompassTakeHomeTest

class AboutRepositoryTest: XCTestCase {
    
    var repository: AboutRepository!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        repository = AboutRepository()
        cancellables = []
    }
    
    override func tearDown() {
        repository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testGetAboutInformationSuccess() {
        let expectation = XCTestExpectation(description: "Fetch about information successfully")
        
        repository.getAboutInformation()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetAboutInformationFailure() {
        let failingRepository = AboutRepositoryFailureMock()
        
        let expectation = XCTestExpectation(description: "Fetch about information with failure")
        
        failingRepository.getAboutInformation()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}

// MARK: - Mocks

class AboutRepositoryFailureMock: AboutRepositoryProtocol {
    func getAboutInformation() -> AnyPublisher<String, Error> {
        return Fail(error: URLError(.badURL))
            .eraseToAnyPublisher()
    }
}
