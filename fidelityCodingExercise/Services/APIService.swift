//
//  APIService.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2017 PPacie. All rights reserved.
//

import Foundation
import Combine


enum APIService {
	static let dummyUrl: URL = URL.init(string: "https://google.com")!

    static var baseURL: String {
        get {
            return "https://api.jikan.moe/v3/search/anime?q="
        }
    }
    
    static func searchBy(url: URL) -> AnyPublisher<[AnimeResult], Error> {
		var request = URLRequest(url: url)
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
