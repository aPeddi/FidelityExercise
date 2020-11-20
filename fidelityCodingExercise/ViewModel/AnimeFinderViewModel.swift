//
//  AnimeFinderViewModel.swift
//  fidelityCodingExercise
//
//  Created by Avinash Peddi on 11/19/20.
//  Copyright © 2020 Avinash Peddi. All rights reserved.
//

import SwiftUI
import Combine

final class AnimeFinderViewModel: ObservableObject {
	@Published private (set) var items = [AnimeProcessedData]()
    @Published var searchString = ""
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    init () {
        print("Init ViewModel")
        
        searchCancellable = $searchString
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
			/// Ground Rules for Search Text
			/// - no empty values
			/// - cannot start with whitespace
			.filter { !$0.isEmpty && $0.first != " " }
            .flatMap { (searchString) -> AnyPublisher<[AnimeResult], Never> in
                print("searchString: \(searchString)")
                return AnimeSearchService.searchBy(string: searchString)
                    .replaceError(with: []) ///TODO: Error Handling
                    .eraseToAnyPublisher()
            }
            .map {
                self.processData(animes: $0)
            }
            .replaceError(with: []) ///TODO: Error Handling
            .assign(to: \.items, on: self)
    }

    private func processData(animes: [AnimeResult]) -> [AnimeProcessedData]  {
        var processedDataItems = [AnimeProcessedData]()
        
        animes.forEach {
			let processedData = AnimeProcessedData(id: String($0.mal_id), title: $0.title, ratings: [$0.rated ?? ""], summary: $0.synopsis, thumbnail: URL.init(string: $0.image_url))
			processedDataItems.append(processedData)
        }
        return processedDataItems
    }
}

