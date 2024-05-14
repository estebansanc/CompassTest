//
//  AboutRepository.swift
//  CompassTakeHomeTest
//
//  Created by Esteban Sánchez on 14/05/2024.
//

import Foundation

protocol AboutRepositoryProtocol {
    func getAboutInformation() async -> String
}

class AboutRepository: AboutRepositoryProtocol {
    
    init() {}
    
    func getAboutInformation() async -> String {
        let url: String = Constants.baseURL
        let response: String = try! await HttpClient.shared.fetch(urlString: url)
        return response
    }
}
