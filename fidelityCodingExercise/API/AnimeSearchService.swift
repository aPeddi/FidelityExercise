//
//  APIService.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import Foundation
import Combine


enum AnimeSearchService {
	///Can be replaced with redirectURL for fallback behaviour
	static let dummyUrl: URL = URL.init(string: "https://google.com")!

	///Base URL for API Connection
	static var baseURL: String {
        get {
            return "https://api.jikan.moe/v3/search/anime?q="
        }
    }
    
    static func searchBy(string: String) -> AnyPublisher<[AnimeResult], Error> {
		///Construct URL Request
		var request = URLRequest(url: URL.init(string: baseURL + string) ?? dummyUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.send(request: request)
            .decode(type: SearchResultData.self, decoder: JSONDecoder())
            .tryMap {
				return $0.results
            }
            .eraseToAnyPublisher()
    }
}
