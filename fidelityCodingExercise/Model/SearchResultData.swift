//
//  Anime.swift
//  CombineBookSearch
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import Foundation

struct SearchResultData: Codable {
	let request_hash: String?
	let prequest_cached: Bool?
	let request_cache_expiry: Int?
	let results: [AnimeResult]
}

struct AnimeResult: Codable {
	let mal_id: Int
	let url: String?
	let image_url: String
	let title: String
	let airing: Bool?
	let synopsis: String
	let type: String?
	let episodes: Int?
	let score: Double?
	let start_date: String?
	let end_date: String?
	let members: Int?
	let rated: String?
}

