//
//  UrlBuilderService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

class UrlBuilderService : UrlBuilding {
    private let logger: Logging = LoggingService.shared
    
    func buildRequestUrl(endpoint: String, urlAddition: String, queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents(string: endpoint + urlAddition)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            logger.logError("Failed to create URL from components. endpoint: \(endpoint), urlAddition: \(urlAddition), queryItems: \(queryItems)")
            return nil
        }
        
        return url
    }
}


