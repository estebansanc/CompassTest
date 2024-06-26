//
//  LogHelper.swift
//  Articles
//
//  Created by Esteban Sánchez on 15/03/2024.
//

import Foundation

class LogHelper {
    static func log<T: Codable>(_ body: T, url: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(body)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("=================== B E G I N ===================")
                print("Begin of request -> \(url.absoluteString) \n")
                print(jsonString)
                print("\nEnd of request -> \(url.absoluteString)")
                print("===================== E N D =====================")
            } else {
                print("Failed to convert JSON data to string.")
            }
        } catch {
            print("Error encoding struct to JSON: \(error)")
        }
    }
    
    static func log(_ data: Data, url: URL) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyPrintedData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            if let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
                print("=================== B E G I N ===================")
                print("Begin of response -> \(url.absoluteString) \n")
                print(prettyPrintedString)
                print("\nEnd of response -> \(url.absoluteString)")
                print("===================== E N D =====================")
            } else {
                print("Failed to convert data to UTF-8 string")
            }
        } catch {
            print("Error al procesar la respuesta del servicio: \(error)")
        }
    }
}
