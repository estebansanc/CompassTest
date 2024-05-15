//
//  AboutRepository.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 14/05/2024.
//

import Foundation
import Combine

protocol AboutRepositoryProtocol {
    func getAboutInformation() -> AnyPublisher<String, Error>
}

class AboutRepository: AboutRepositoryProtocol {
    
    init() {}
    
    func getAboutInformation() -> AnyPublisher<String, Error> {
        if let response = UserDefaultsHelper.getAboutResponse() {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            guard let url = URL(string: Constants.baseURL) else {
                return Fail(error: URLError(.badURL))
                    .eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { String(data: $0.data, encoding: .utf8) ?? "" }
                .handleEvents(receiveOutput: { response in
                    UserDefaultsHelper.saveAboutResponse(response)
                    LogHelper.log(response, url: url)
                })
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        }
    }
}
